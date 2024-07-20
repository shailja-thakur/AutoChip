module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Declare wire variables
wire sop0, sop1, pos0, pos1;

// Calculate out_sop output
assign sop0 = c & d;
assign sop1 = (~a & ~b & c);
assign out_sop = sop0 | sop1;

// Calculate pos0 and pos1 wires
assign pos0 = c & (~b | d) & (~a | b);
assign pos1 = c & (~a | d);

// Calculate out_pos output using ternary expression
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
