module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// First always block: Logic description of the state transition
	always @(*) begin
		q_next = q[4:1]; 
		q_next[4] = q[0]; 
		q_next[2] = q_next[2] ^ q[0];
	end

	// Second always block: State transition on the positive edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h01; // Reset value
		else
			q <= q_next;
	end

endmodule
