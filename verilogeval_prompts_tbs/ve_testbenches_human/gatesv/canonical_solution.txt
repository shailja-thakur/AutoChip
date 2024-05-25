
	assign out_both = in[2:0] & in[3:1];
	assign out_any = in[2:0] | in[3:1];
	assign out_different = in^{in[0], in[3:1]};
	
endmodule
