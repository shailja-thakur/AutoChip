module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// Always block triggered when q changes
	always @(*) begin
		q_next = {q[3:0], q[0]};  // q_next receives q[4:1] and the LSB q[0]
		q_next[4] = q[0];         // q_next[4] receives q[0]
		q_next[2] = q_next[2] ^ q[0]; // q_next[2] xored with q[0]
	end

	// Always block triggered on posedge of clk
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1; // Reset value
		end else begin
			q <= q_next; // State transition
		end
	end

endmodule
