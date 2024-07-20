module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// internal signal for state transition
	reg [4:0] q_next;

	// initialize q_next to 5'h1 at reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_next <= 5'h1;
		end else begin
			q_next <= q_next;
		end
	end

	// state transitions
	always @(q) begin
		q_next[4:1] = q[3:0];
		q_next[0] = q[4];
		q_next[2] = q[2] ^ q[0];
	end

	// assign q_next to q at positive edge of clk
	always @(posedge clk) begin
		q <= q_next;
	end

endmodule
