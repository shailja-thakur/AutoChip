module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	always @(*)
	begin
		q_next = q[4:1]; // Assign q_next with the value of q except the LSB bit
		q_next[4] = q[0]; // Assign q_next[4] with the value of q[0]
		q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
	end
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			q <= 5'h1; // Reset value
		else
			q <= q_next; // State transition
	end

endmodule
