module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// internal signal to hold the next state of q
	reg [4:0] q_next;

	// state transition logic
	always @(q) begin
		q_next[4:1] = q[3:0];
		q_next[0] = q[4];
		q_next[2] = q[0] ^ q[2];
	end

	// positive edge-triggered clocked logic
	always @(posedge clk) begin
		if (reset) begin
			q <= 5'h1; // reset value
		end else begin
			q <= q_next; // state transition
		end
	end

endmodule
