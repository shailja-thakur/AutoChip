module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
	// Corrected module definition

	// Define internal wire to store selected output
	wire [99:0] selected_output;

	// Multiplexer logic
	assign selected_output = (sel == 1'b0) ? a : b;

	// Assign selected output to output port
	assign out = selected_output;
endmodule
