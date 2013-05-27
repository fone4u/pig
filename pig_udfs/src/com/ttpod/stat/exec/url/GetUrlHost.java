package com.ttpod.stat.exec.url;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.pig.EvalFunc;
import org.apache.pig.FuncSpec;
import org.apache.pig.data.DataType;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;
import org.apache.pig.impl.logicalLayer.FrontendException;
import org.apache.pig.impl.logicalLayer.schema.Schema;

public class GetUrlHost extends EvalFunc<String> {

	

	@Override
	public String exec(Tuple input) throws IOException {
		 if (input == null || input.size() == 0)
		      return null;
		    String str="";
		    try{
		      str = (String)input.get(0);
		      return new URL(str).getHost().toLowerCase();
		    } catch (MalformedURLException me) {
		      System.err.println("piggybank.evaluation.util.apachelogparser.HostExtractor: "+
		          "url parsing exception for "+str);
		      return null;
		    } catch (Exception e) {
		      throw new IOException("Caught exception processing input row ", e);
		    }
	}
	
	 @Override
	  public List<FuncSpec> getArgToFuncMapping() throws FrontendException {
	    List<FuncSpec> funcList = new ArrayList<FuncSpec>();
	    funcList.add(new FuncSpec(this.getClass().getName(), 
	        new Schema(new Schema.FieldSchema(null, DataType.CHARARRAY))));

	    return funcList;
	  }

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		Tuple t = TupleFactory.getInstance().newTuple(1);
		t.set(0, "http://www.google.co.in/advanced_search?q=google+Advanced+Query&hl=en");
		String str = new GetUrlHost().exec(t);
		System.out.println(str);
	}
}
