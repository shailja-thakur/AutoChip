module top_module (
	input clk,
	input in,
	output logic out
);

// D flip-flop
logic ff_d;
always @(posedge clk)
    ff_d <= in;

// Two-input XOR
logic xor_out;
assign xor_out = ff_d ^ out;

// Output
assign out = xor_out;

endmodule
