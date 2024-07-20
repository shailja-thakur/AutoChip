module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
	// Define internal wire to hold the selected value
	wire [99:0] selected_value;

	// Use the select signal sel to determine the selected value
	assign selected_value = sel ? b : a;

	// Assign the selected value to the output port
	assign out = selected_value;
endmodule
