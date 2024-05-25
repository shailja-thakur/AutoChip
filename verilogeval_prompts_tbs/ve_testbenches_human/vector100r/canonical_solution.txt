	
	always_comb 
		for (int i=0;i<$bits(out);i++)
			out[i] = in[$bits(out)-i-1];
	
endmodule
