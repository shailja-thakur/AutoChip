module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Initial value of Q set to 0
	initial Q = 0;

	// Always block triggered on the rising edge of clk
	always @(posedge clk) begin
		if (L) begin
			Q <= r_in;  // If L is high, set Q to r_in
		end else begin
			Q <= q_in;  // If L is low, set Q to q_in
		end
	end
endmodule
