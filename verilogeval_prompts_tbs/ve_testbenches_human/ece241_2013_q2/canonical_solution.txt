	
	wire pos0, pos1;
	assign out_sop = c&d | ~a&~b&c;
	assign pos0 = c & (~b|d)&(~a|b);
	assign pos1 = c & (~b|d)&(~a|d);
	
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
endmodule
