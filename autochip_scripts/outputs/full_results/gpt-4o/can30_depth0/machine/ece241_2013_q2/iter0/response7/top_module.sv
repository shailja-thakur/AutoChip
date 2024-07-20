module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Sum of Products (SOP)
	wire temp1, temp2;
	assign temp1 = c & d;
	assign temp2 = (~a) & (~b) & c;
	assign out_sop = temp1 | temp2;
	
	// Product of Sums (POS)
	wire pos0, pos1;
	assign pos0 = c & ((~b) | d) & ((~a) | b);
	assign pos1 = c & ((~b) | d) & ((~a) | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
	
endmodule
