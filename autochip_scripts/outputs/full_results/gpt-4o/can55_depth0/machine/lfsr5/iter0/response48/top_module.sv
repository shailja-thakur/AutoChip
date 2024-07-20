module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] q_next;

	// State transitions
	always @(*) begin
		q_next = q[4:1];      // q_next takes q except the LSB bit
		q_next[4] = q[0];     // q_next[4] is assigned with q[0] (LSB bit)
		q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
	end

	// State assignment at clock edge
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h1;       // reset value
		else
			q <= q_next;     // state transition
	end

endmodule
