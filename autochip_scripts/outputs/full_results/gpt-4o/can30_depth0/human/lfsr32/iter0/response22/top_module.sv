module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Polynomial for taps: 32, 22, 2, 1 is represented as x^32 + x^22 + x^2 + x^1 + 1
	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			// Feedback calculation
			q <= {q[30:0], (q[31] ^ q[21] ^ q[1] ^ q[0])};
		end
	end
endmodule
