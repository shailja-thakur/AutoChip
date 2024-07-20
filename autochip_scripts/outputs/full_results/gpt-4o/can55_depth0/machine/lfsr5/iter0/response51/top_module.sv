module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
  
	reg [4:0] q_next;

	// First always block to define state transitions
	always @(*) begin
		q_next = {q[4:1], q[0]}; // q_next is q shifted right by 1, with LSB bit as the new MSB
		q_next[4] = q[0]; // LSB bit of q becomes MSB of q_next
		q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
	end

	// Second always block to update q on the positive edge of clk or reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h1; // Reset value
		else
			q <= q_next; // State transition
	end

endmodule
