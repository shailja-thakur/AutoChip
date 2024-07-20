module top_module (
	input clk,
	input in,
	output logic out
);

reg xor_output;
reg flip_flop_output;

// Implement XOR gate
always @(in or flip_flop_output)
    xor_output <= in ^ flip_flop_output;

// Implement D flip-flop
always @(posedge clk)
    flip_flop_output <= xor_output;

// Assign output from D flip-flop
assign out = flip_flop_output;

endmodule
