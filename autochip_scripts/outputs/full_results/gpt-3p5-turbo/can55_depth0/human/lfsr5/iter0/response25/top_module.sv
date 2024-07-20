module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define state variables
	reg [4:0] state;

	// Define taps
	parameter tap1 = 5;
	parameter tap2 = 3;

	// Counter for cycling through states
	reg [4:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Synchronous reset
			state <= 5'b1;
			count <= 5'b0;
		end else begin
			// Calculate next state using XOR
			state <= state[tap1] ^ state[tap2];
			
			// Increment count to keep track of cycles
			count <= count + 1;
		end
	end
	
	// Output q with current state
	assign q = state;

endmodule
