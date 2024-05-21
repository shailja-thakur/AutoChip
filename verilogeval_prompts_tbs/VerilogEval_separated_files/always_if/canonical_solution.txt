
	assign out_assign = (sel_b1 & sel_b2) ? b : a;
	always @(*) out_always = (sel_b1 & sel_b2) ? b : a;
	
endmodule
