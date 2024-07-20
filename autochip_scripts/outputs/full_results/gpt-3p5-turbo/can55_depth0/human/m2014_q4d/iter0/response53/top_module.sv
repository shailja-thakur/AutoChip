module top_module (
	input clk,
	input in,
	output logic out
);

	reg flip_flop;
	always @(posedge clk)
		flip_flop <= in ^ out;

	assign out = flip_flop;

endmodule
