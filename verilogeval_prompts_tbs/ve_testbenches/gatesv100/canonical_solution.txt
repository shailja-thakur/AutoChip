
	assign out_both = in & in[99:1];
	assign out_any = in | in[99:1];
	assign out_different = in^{in[0], in[99:1]};
	
endmodule
