module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Intermediate signal to hold the next state value of q
	reg [4:0] q_next;

	// State transition always block triggered by changes to q
	always @ (q)
	begin
		q_next[4:1] = q[3:0];  // Assign q_except_lsb to q_next[4:1]
		q_next[4] = q[0];      // Assign q_lsb to q_next[4]
		q_next[2] = q[2] ^ q[0]; // XOR q_lsb with q_next[2]
	end

	// Output assignment always block triggered by the positive edge of clk
	always @(posedge clk)
	begin
		if (reset)
			q <= 5'h1; // Reset value of q
		else
			q <= q_next; // State transition value of q
	end

endmodule
