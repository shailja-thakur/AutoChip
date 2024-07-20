module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Calculate out_sop
wire temp1 = c & d;
wire temp2 = !(a | b) & c;
assign out_sop = temp1 | temp2;

// Calculate out_pos
wire pos0 = c & (!b | d) | (!a & b);
wire pos1 = c & (!a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bX;

endmodule
