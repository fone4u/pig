package com.ttpod.stat.exec;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.pig.EvalFunc;
import org.apache.pig.PigWarning;
import org.apache.pig.builtin.LOG;
import org.apache.pig.data.DataBag;
import org.apache.pig.data.DefaultBagFactory;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;
import org.apache.pig.impl.logicalLayer.schema.Schema;
import org.apache.pig.impl.util.Utils;
import org.apache.pig.parser.ParserException;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.ObjectNode;

public class JsonToMapExec extends EvalFunc<Map<String, Object>> {

	private static final TupleFactory tupleFactory = TupleFactory.getInstance();
	private ObjectMapper mapper = new  ObjectMapper();

	@Override
	public Map<String, Object> exec(Tuple input)  {
		Map<String, Object> values = new HashMap<String, Object>();
		try {
			// Verify the input is valid, logging to a Hadoop counter if not.
			if (input == null || input.size() < 1) {
				//throw new IOException("Not enough arguments to "+ this.getClass().getName() + ": got " + input.size()+ ", expected at least 1");
				return null;
			}

			if (input.get(0) == null) {
				// counterHelper.incrCounter(getClass().getName(),
				// "NullJsonString", 1L);
				return null;
			}

			String line = (String) input.get(0);
			//System.out.println(line);
			JsonNode node = mapper.readTree(line);
			//System.out.println(mapper.readTree(line));
			flatten_value(node, values);
			return values;
			// return parseStringToMap(jsonLiteral);
		} catch (Exception e) {
			
			warn("******Error in " + getClass() + " with input " + input, PigWarning.ACCESSING_NON_EXISTENT_FIELD);
			//System.out.println("yichang");
			return null;	
		}
	}

	private void flatten_value(JsonNode node, Map<String, Object> values) {
		Iterator<String> keys = node.getFieldNames();
		Iterator<JsonNode> nodes = node.getElements();
		while (keys.hasNext()) {
			String key = keys.next();
			JsonNode value = nodes.next();

			//System.out.println(key + ":" + value.toString());
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
				values.put(key,value != null ? value.toString().replaceAll("[\"]", ""): null);
			}
		}
	}

	private void flatten_array(JsonNode value, DataBag bag) {
		if (value.isArray()) {
			ArrayNode array = (ArrayNode) value;
			DataBag b = DefaultBagFactory.getInstance().newDefaultBag();
			for (JsonNode innervalue : array) {
				flatten_array(innervalue, b);
			}
			bag.addAll(b);
		} else if (value.isObject()) {
			Map<String, Object> values2 = new HashMap<String, Object>();
			flatten_value((ObjectNode) value, values2);
			bag.add(tupleFactory.newTuple(values2));
		} else {
			if (value != null) {
				warn("******Error in " + getClass() + " with input " + value, PigWarning.ACCESSING_NON_EXISTENT_FIELD);
				//System.out.println("yichang");
				//bag.add(tupleFactory.newTuple(value));
			}
		}
	}
	
	@Override
	public Schema outputSchema(Schema input) {
	   try {
	      return Utils.getSchemaFromString("json: [bytearray]");
	    } catch (ParserException e) {
	      throw new RuntimeException(e);
	    }
	  }


	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String error = "{\"data\":[\"[(this Collection)]\"],\"param\":{\"uid\":\"860403002510811\",\"f\":\"f1\",\"v\":\"v5.4.0.2013051616\",\"app\":\"ttpod\",\"hid\":\"\",\"s\":\"s200\",\"rom\":\"MOTO%2FTAHITI%2FTAHITI%2FTAHITI%3A2.2.2%2FTHTTD_N_01.01.36I%2F0%3Auser%2Frelease-keys\",\"active\":1,\"mid\":\"MT620\",\"imsi\":\"460000834573761\",\"splus\":\"2.2.2%2F8\",\"tid\":0,\"net\":3}}";

		String error2 = "{\"data\":[{\"optvalue2\":0,\"v\":1,\"time\":\"2013052700\",\"module\":\"song\",\"value\":1,\"origin\":\"local\",\"optvalue\":0,\"type\":\"listen_info\"},{\"optvalue2\":0,\"v\":1,\"time\":\"2013052700\",\"module\":\"song\",\"value\":1,\"origin\":\"local\",\"optvalue\":0,\"type\":\"listen_info\"}],\"param\":{\"uid\":\"864400014008442\",\"f\":\"f384\",\"v\":\"v5.4.0.2013051616\",\"app\":\"ttpod\",\"hid\":\"\",\"s\":\"s200\",\"rom\":\"lenovo%2Fa65cu%2Fa65cu%3A2.3.5%2FGRJ90%2FA65_S219_120307.20120307%3Auser%2Frelease-keys\",\"active\":1,\"mid\":\"Lenovo+A65\",\"imsi\":\"460015108310540\",\"splus\":\"2.3.5%2F10\",\"tid\":0,\"net\":3}}";
		
    	String line = "{\"f\":\"f0\",\"uid\":\"359118045767495\",\"v\":\"v5.1.0.2013032716\",\"rom\":\"htc_asia_tw%2Fhtc_pyramid%2Fpyramid%3A4.0.3%2FIML74K%2F391535.152%3Auser%2Frelease-keys\",\"s\":\"s200\",\"hid\":\"6074275084061480\",\"active\":\"1\",\"splus\":\"4.0.3%2F15\",\"mid\":\"HTC+Sensation+XE+with+Beats+Audio+Z715e\",\"imsi\":\"466923101938063\",\"net\":2}";
    	try {
			System.out.println(new JsonToMapExec().exec(tupleFactory.newTuple(error)));
			//System.out.println(new JsonToMapExec().outputSche(error));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
