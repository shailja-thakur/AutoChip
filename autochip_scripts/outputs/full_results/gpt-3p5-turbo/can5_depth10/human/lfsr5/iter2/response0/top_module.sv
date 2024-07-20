module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Register to store the current state of the LFSR
	reg [4:0] state;
	
	// Internal wire to store next state
	reg [4:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 5'b1;
		else begin
			next_state[4] <= state[2] ^ state[0];
			next_state[3:0] <= state[4:1];
			state <= next_state;
		end
	end

	assign q = state;

endmodule
