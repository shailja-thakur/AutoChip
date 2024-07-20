module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// internal signal for state transition
	reg [4:0] q_next;

	always @(q) begin
		q_next[4:1] = q[3:0];
		q_next[0] = q[4];
		q_next[2] = q[3] ^ q[0];
	end

	always @(posedge clk) begin
		if (reset) begin
			q <= 5'h1;
		end else begin
			q <= q_next;
		end
	end

endmodule
