module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] sel_inverse;  // Wire to hold the inverted value of 'sel'

assign sel_inverse = ~sel;  // Invert the value of 'sel'

assign out = in & (1 << sel_inverse);  // Perform bitwise AND between 'in' and a left-shifted 1 by 'sel_inverse'

endmodule
