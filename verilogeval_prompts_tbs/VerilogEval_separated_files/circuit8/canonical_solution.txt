
	always @(negedge clock)
		q <= a;
		
	always @(*)
		if (clock)
			p = a;
endmodule
