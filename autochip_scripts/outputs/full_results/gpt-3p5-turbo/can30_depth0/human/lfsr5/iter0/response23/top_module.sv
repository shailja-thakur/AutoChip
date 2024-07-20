module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] state;

	// Initialization
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 5'b1;
		else begin
			// Feedback logic
			state[0] <= state[4] ^ state[2] ^ state[0];
			state[1] <= state[0];
			state[2] <= state[1];
			state[3] <= state[2];
			state[4] <= state[3];
		end
	end
	
	assign q = state;
endmodule
