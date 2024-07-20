module top_module (
	input clk,
	input in,
	output logic out
);

	// D Flip Flop
	logic dff;
	always_ff @(posedge clk)
		dff <= in ^ out;

	// Assign flip flop output to the output port
	assign out = dff;

endmodule
