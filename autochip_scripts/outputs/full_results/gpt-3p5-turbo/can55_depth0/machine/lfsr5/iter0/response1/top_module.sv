module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:1] q_next;
	
	always @(q) begin
		q_next = q[4:1];     // Assign q_next with q[4:1]
		q_next[4] = q[0];    // Assign q_next[4] with q[0]
		q_next[2] = q_next[2] ^ q[0];    // XOR q_next[2] with q[0]
	end
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 5'h1;    // Reset value of q
		end else begin
			q <= q_next;    // Assign q with q_next
		end
	end
	
endmodule
