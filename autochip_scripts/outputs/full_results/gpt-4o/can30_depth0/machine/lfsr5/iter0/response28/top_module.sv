module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// Always block for state transitions
	always @(*) begin
		q_next = {q[0], q[4:1]}; // q_next[4:1] = q[3:0], q_next[0] = q[4]
		q_next[2] = q[2] ^ q[0]; // q_next[2] = q[2] XOR q[0]
	end

	// Always block for sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1;
		end else begin
			q <= q_next;
		end
	end

endmodule
