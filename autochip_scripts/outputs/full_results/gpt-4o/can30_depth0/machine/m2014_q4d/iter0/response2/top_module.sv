module top_module (
	input clk,
	input in,
	output logic out
);

	// Initialize the output signal to 0
	initial begin
		out = 0;
	end

	// Always block to trigger on positive edge of clk
	always_ff @(posedge clk) begin
		out <= in ^ out;
	end

endmodule
