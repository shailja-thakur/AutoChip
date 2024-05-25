	
	assign out_assign = a ^ b;
	always @(*) out_always_comb = a ^ b;
	always @(posedge clk) out_always_ff <= a ^ b;
	
endmodule
