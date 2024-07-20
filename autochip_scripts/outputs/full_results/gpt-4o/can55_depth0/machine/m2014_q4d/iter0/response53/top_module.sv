module top_module (
	input clk,
	input in,
	output logic out
);

	// Initialize the output signal to 0
	initial out = 0;

	always @(posedge clk) begin
		out <= in ^ out;
	end

endmodule
