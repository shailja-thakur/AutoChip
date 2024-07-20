module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Signal to hold the next state of q
	reg [4:0] q_next;

	// State transition always block triggered by q changes
	always @(q) begin
		q_next[4:1] = q[4:1];
		q_next[4] = q[0];
		q_next[2] = q[2] ^ q[0];
	end

	// Logic description always block triggered by positive edge of clk
	always @(posedge clk) begin
		if (reset) begin
			q <= 5'h1; // Reset value
		end else begin
			q <= q_next; // State transition
		end
	end

endmodule
