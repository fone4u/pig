package com.ttpod.stat;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.pig.EvalFunc;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;
import org.apache.pig.impl.logicalLayer.schema.Schema;
import org.apache.pig.impl.util.Utils;
import org.apache.pig.parser.ParserException;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.ObjectNode;
/**
 * Transforms a Json string into a Pig map whose value type is chararray. Only goes one level deep;
 * All input map values are converted to strings via {@link Object#toString()}.
 */
public class JsonToMap extends EvalFunc<Map<String, String>> {
 // private static final Logger LOG = LoggerFactory.getLogger(JsonToMap.class);
	  private static final TupleFactory tupleFactory = TupleFactory.getInstance();
	  private ObjectMapper mapper;

  @Override
  public Schema outputSchema(Schema input) {
    try {
      return Utils.getSchemaFromString("json: [chararray]");
    } catch (ParserException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public Map<String, String> exec(Tuple input) throws IOException {
    try {
   
      if (input.get(0) == null) {
        return null;
      }

      String jsonLiteral = (String) input.get(0);
      return parseStringToTuple(jsonLiteral);
    } catch (ExecException e) { 
      throw new IOException(e);
    }
  }

  
  protected Tuple parseStringToTuple(String line) throws IOException {
      try {
          Map<String, Object> values = new HashMap<String, Object>();
          JsonNode node = mapper.readTree(line);
          System.out.println(mapper.readTree(line));
          flatten_value(node, values);
          return tupleFactory.newTuple(values);
      } catch (NumberFormatException e) {
          int errCode = 6018;
          String errMsg = "Error while reading input - Very big number exceeds the scale of long: " + line;
          throw new ExecException(errMsg, errCode, PigException.REMOTE_ENVIRONMENT, e);
      } catch (JsonParseException e) {
          int errCode = 6018;
          String errMsg = "Error while reading input - Could not json-decode string: " + line;
          throw new ExecException(errMsg, errCode, PigException.REMOTE_ENVIRONMENT, e);
      }
  }

  private void flatten_value(JsonNode node, Map<String, Object> values) {
      Iterator<String> keys = node.getFieldNames();
      Iterator<JsonNode> nodes = node.getElements();
      while (keys.hasNext()) {
          String key = keys.next();
          JsonNode value = nodes.next();

          System.out.println(key + ":" + value.toString());
          if (value.isArray()) {
              ArrayNode array = (ArrayNode) value;
              DataBag bag = DefaultBagFactory.getInstance().newDefaultBag();
              for (JsonNode innervalue : array) {
                  flatten_array(innervalue, bag);
              }
              values.put(key, bag);
          } else if (value.isObject()) {
              Map<String, Object> values2 = new HashMap<String, Object>();
              flatten_value((ObjectNode) value, values2);
              values.put(key, tupleFactory.newTuple(values2));
          } else {
              values.put(key, value != null ? value.toString().replaceAll("[\"]", "") : null);
          }
      }
  }

  private void flatten_array(JsonNode value, DataBag bag) {
      if(value.isArray()) {
          ArrayNode array = (ArrayNode)value;
          DataBag b = DefaultBagFactory.getInstance().newDefaultBag();
          for(JsonNode innervalue :array) {
              flatten_array(innervalue, b);
          }
          bag.addAll(b);
      } else if (value.isObject()){
          Map<String, Object> values2 = new HashMap<String, Object>();
          flatten_value((ObjectNode)value, values2);
          bag.add(tupleFactory.newTuple(values2));
      } else {
          if(value !=null) {
              bag.add( tupleFactory.newTuple(value));
          }
      }
  }
  
//  protected Map<String, String> parseStringToMap(String line) {
//    try {
//      Map<String, String> values = Maps.newHashMap();
//      JSONObject jsonObj = (JSONObject) jsonParser.parse(line);
//      for (Object key : jsonObj.keySet()) {
//        Object value = jsonObj.get(key);
//        values.put(key.toString(), value != null ? value.toString() : null);
//      }
//      return values;
//    } catch (ParseException e) {
//      LOG.warn("Could not json-decode string: " + line, e);
//      return null;
//    } catch (NumberFormatException e) {
//      LOG.warn("Very big number exceeds the scale of long: " + line, e);
//      return null;
//    }
 //}

}
