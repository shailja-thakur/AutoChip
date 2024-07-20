module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] sel_extended;
wire [7:0] selected_bits;

assign out = selected_bits[0];

// Extend the selection vector to match the width of the input vector
assign sel_extended = {8{sel}};

// Select the corresponding bits from the input vector
assign selected_bits = in[sel_extended];

endmodule
