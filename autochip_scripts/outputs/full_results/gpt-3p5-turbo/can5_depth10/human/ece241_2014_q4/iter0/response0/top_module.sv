module top_module (
	input clk,
	input x,
	output z
);

reg d_ff1, d_ff2, d_ff3;
wire xor_input, xor_out;
wire and_input, and_out;
wire or_input, or_out;

assign xor_input = x ^ d_ff1;
assign and_input = ~d_ff2;
assign or_input = ~d_ff3;

xor_gate xor1 (.a(xor_input), .b(d_ff1), .z(xor_out));
and_gate and1 (.a(and_input), .b(d_ff2), .z(and_out));
or_gate or1 (.a(or_input), .b(d_ff3), .z(or_out));

d_flip_flop d_ff1_inst (.clk(clk), .reset(1'b0), .d(xor_out), .q(d_ff1));
d_flip_flop d_ff2_inst (.clk(clk), .reset(1'b0), .d(and_out), .q(d_ff2));
d_flip_flop d_ff3_inst (.clk(clk), .reset(1'b0), .d(or_out), .q(d_ff3));

xnor_gate xnor1 (.a(d_ff1), .b(d_ff2), .c(d_ff3), .z(z));

endmodule
