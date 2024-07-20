module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	always @(q) begin
		reg [4:1] q_next; // define temporary variable for state transition
		q_next = q[4:1]; // assign q_next with q[4:1]
		q_next[4] = q[0]; // assign q_next[4] with q[0]
		q_next[2] = q_next[2] ^ q[0]; // xor q_next[2] with q[0]
		q = q_next; // assign q with q_next
	end
	
	always @(posedge clk) begin
		if (reset) begin
			q = 5'h1; // assign reset value to q
		end else begin
			q = q_next; // assign q with q_next
		end
	end

endmodule
