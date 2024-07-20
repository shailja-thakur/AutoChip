module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] index;
wire [255:0] selected_input;

// Generate index values for bit selection
assign index = sel;

// Select the appropriate input bits based on sel
assign selected_input = in >> (index * 256);

// Output the selected input bit
assign out = selected_input[0];

endmodule
