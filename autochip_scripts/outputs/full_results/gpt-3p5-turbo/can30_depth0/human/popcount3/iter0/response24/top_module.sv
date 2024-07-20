module top_module (
	input [2:0] in,
	output [1:0] out
);

	assign out[0] = in[0] + in[1] + in[2]; // Add all bits
	assign out[1] = out[0] == 3'b000 ? 1'b0 : 1'b1; // Check if all bits are '0's
endmodule
