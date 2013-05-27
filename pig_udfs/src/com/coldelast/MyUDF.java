package com.coldelast;
import java.io.IOException;

import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;




public class MyUDF extends EvalFunc<Double> {
	//@Override
	public Double exec(Tuple input) throws IOException {
		if (input == null || input.size() == 0) {
			return null;
			}
		try {
			Double val = (Double) input.get(0);
			val = (val + 500 - 300) / 2.6;
			return val;
			} catch (Exception e) {
				throw new IOException(e.getMessage());
				}
		}
	}