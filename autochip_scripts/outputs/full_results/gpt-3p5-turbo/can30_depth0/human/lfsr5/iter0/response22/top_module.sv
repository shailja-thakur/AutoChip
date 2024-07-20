module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	// Internal signals
	reg [4:0] state;
	
	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 5'b00001;
		else begin
			state[4] <= state[3];
			state[3] <= state[2] ^ state[0];
			state[2] <= state[1];
			state[1] <= state[0];
			state[0] <= state[3];
		end
	end
	
	// Output assignment
	always @(state) begin
		q <= state;
	end
	
endmodule
