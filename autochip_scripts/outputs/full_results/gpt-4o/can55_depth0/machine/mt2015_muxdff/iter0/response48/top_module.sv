module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Initialize the output register
	initial begin
		Q = 0;
	end

	// Evaluate on the rising edge of the clock
	always @(posedge clk) begin
		if (L) begin
			Q <= r_in; // If select signal is high, set Q to r_in
		end else begin
			Q <= q_in; // If select signal is low, set Q to q_in
		end
	end

endmodule
