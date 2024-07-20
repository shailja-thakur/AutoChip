module top_module (
	input [7:0] in,
	output [31:0] out
);
    // Replicate the sign bit 24 times and concatenate with the input
    assign out = {{24{in[7]}}, in};
endmodule
