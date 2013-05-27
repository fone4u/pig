package com.ttpod.stat.exec.url;

import java.io.IOException;
import java.net.URLDecoder;


import org.apache.pig.EvalFunc;
import org.apache.pig.PigWarning;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;



public class GetItemFromQueryString extends EvalFunc<String> {

	@Override
	public String exec(Tuple input) throws IOException {
		if (input == null || input.size() != 2){
			
			warn("this method must have two args", PigWarning.ACCESSING_NON_EXISTENT_FIELD );
			return null;
		}
		String url = (String) input.get(0);
		if (url.charAt(0)=='?'){
			url = url.substring(1);
		}
		String keyWord = (String)input.get(1);
		if (url == null)
			return null;
		String deurl = myDecode(url);
		String[] surl = deurl.split("&");
		for (int i = 0; i < surl.length; i++) {
			String[] kv = surl[i].split("=");
			if(kv[0].equals(keyWord)){
				try {
					return kv[1];
				} catch (Exception e) {
					//e.printStackTrace();
				}
				return null;
			}
		}
		return null;
	}

//	@Override
//	public List<FuncSpec> getArgToFuncMapping() throws FrontendException {
//		List<FuncSpec> funcList = new ArrayList<FuncSpec>();
//		funcList.add(new FuncSpec(this.getClass().getName(), new Schema(
//				new Schema.FieldSchema(null, DataType.CHARARRAY))));
//
//		return funcList;
//	}

	private String myDecode(String string) {
		try {
			return  URLDecoder.decode(string, "UTF-8");			
		} catch (Exception e1) {			
			try {
				return URLDecoder.decode(string, "gb2312");
			} catch (Exception e2) {
				try {
					return URLDecoder.decode(string, "gbk");
				} catch (Exception e3) {
					warn("===========================", PigWarning.FIELD_DISCARDED_TYPE_CONVERSION_FAILED);
					warn(string, PigWarning.FIELD_DISCARDED_TYPE_CONVERSION_FAILED);
					warn("===========================", PigWarning.FIELD_DISCARDED_TYPE_CONVERSION_FAILED);
					return string;
				}
			}
		}
		
	}

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		GetItemFromQueryString g = new GetItemFromQueryString();
		Tuple t = TupleFactory.getInstance().newTuple(2);;
		
		//String ff = "a=&ds=1&from=ss&channelid=-3&channelname=&searchid=358076508233182&neid=2924638&songname=%E4%B8%80%E5%AE%9A%E8%A6%81%E5%B9%B8%E7%A6%8F&singername=%E6%9D%A8%E5%B9%82&order=1&uid=356708047352461&hid=&v=v3.9.0.2012072518&f=f220&s=s200&imsi=460002780180315&net=2&mid=HTC%2BDesire%2BS&splus=2.3.3%2F10&rom=hkcsl_cht%2Fhtc_saga%2Fsaga%3A2.3.3%2FGRI40%2F27073%3Auser%2Frelease-keys&active=1&r=0.4983312040567398&resVersion=YYC_V4_v3.9.0.2012072518_201212251000";
		String ff ="%22";
		//String d = "?playtime=0&loadingtime=0&buffertime=10800&buffercount=35&loadsuccess=0&song_name=%E5%86%9B%E6%B8%AF%E4%B9%8B%E5%A4%9C&singer_name=%E8%8B%8F%E5%B0%8F%E6%98%8E&songtime=163&url=http%3A%2F%2Fcs1.vy.hotchanson.com%2Fm4a_96_4%2Fc8%2Fd3%2Fc828b26077c27e269596908cf6358ed3.m4a%3Fk%3De9d48a695345abe1%26t%3D1366166754&changeaction=0&changestatus=2&a=listen&channel=plaza&r=0.7241084910929203&project=player_v1.6.3";
		//System.out.println(d);
		//d = d.substring(1);
		System.out.println(ff);
		t.set(0, ff);
		t.set(1, "songname");
		System.out.println(g.exec(t));;
	}

}
