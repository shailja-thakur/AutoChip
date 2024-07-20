module top_module (
	input clk,
	input in,
	output logic out
);

	// Output flip-flop initialized to 0.
	initial out = 0;

	// Always block triggered on the positive edge of the clock signal.
	always_ff @(posedge clk) begin
		out <= in ^ out;
	end

endmodule
