module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create internal wires to store the selected bits
wire [255:0] selected_bits;

// Generate the individual selected bits based on the sel input
assign selected_bits[0] = in[4*sel +: 4];
assign selected_bits[1] = in[4*sel + 4 +: 4];
assign selected_bits[2] = in[4*sel + 8 +: 4];
assign selected_bits[3] = in[4*sel + 12 +: 4];

// Assign the selected bits as the output
assign out = selected_bits;

endmodule
