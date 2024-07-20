module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic flip_flop_output;

// Two-input XOR gate
assign xor_output = in ^ flip_flop_output;

// D flip-flop
always @(posedge clk)
    flip_flop_output <= xor_output;

// Output
assign out = flip_flop_output;

endmodule
