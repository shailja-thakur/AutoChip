module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Initialize Q to 0
	initial begin
		Q = 0;
	end

	// Always block triggered on the rising edge of the clock
	always @(posedge clk) begin
		if (L) begin
			Q <= r_in; // If select signal L is high, set Q to r_in
		end else begin
			Q <= q_in; // If select signal L is low, set Q to q_in
		end
	end

endmodule
