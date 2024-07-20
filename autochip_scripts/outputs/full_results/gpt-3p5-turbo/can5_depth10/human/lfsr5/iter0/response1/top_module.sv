module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	// Define the flip-flops
	reg [4:0] d, q_next;

	// Combinational logic for the taps
	assign q_next[4] = q[3] ^ q[4];
	assign q_next[3] = q[2];
	assign q_next[2] = q[1];
	assign q_next[1] = q[0];
	assign q_next[0] = q[4];

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'b1;
		else
			q <= q_next;
	end
endmodule
