module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define intermediate wires
wire sop_c_d;
wire sop_not_a_b_and_c;

wire pos_not_a_and_b_or_d;
wire pos_not_a_and_d;

// Assignments for out_sop output
assign sop_c_d = c & d;
assign sop_not_a_b_and_c = (~a & ~b & c);
assign out_sop = sop_c_d | sop_not_a_b_and_c;

// Assignments for out_pos output
assign pos_not_a_and_b_or_d = (~a & b) | (~b & d);
assign pos_not_a_and_d = (~a & d);

assign out_pos = (pos_not_a_and_b_or_d == pos_not_a_and_d) ? pos_not_a_and_b_or_d : 1'bx;

endmodule
