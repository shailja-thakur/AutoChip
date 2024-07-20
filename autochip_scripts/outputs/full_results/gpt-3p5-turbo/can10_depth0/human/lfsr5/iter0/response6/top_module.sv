module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Registers declaration
	reg [4:0] next_q;
	reg [4:0] state;

	// Always block for state update
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 1;
		else
			state <= next_q;
	end

	// Always block for next_q calculation
	always @(state) begin
		next_q[4] = state[3] ^ state[0];
		next_q[3] = state[2];
		next_q[2] = state[1];
		next_q[1] = state[0];
		next_q[0] = state[4];
	end
	
	// Output assignment
	assign q = state;
	
endmodule
