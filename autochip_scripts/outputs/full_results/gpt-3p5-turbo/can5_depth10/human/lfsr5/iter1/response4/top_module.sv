module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Register to store the current state of the LFSR
	reg [4:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 5'b1;  // Reset the LFSR output to 1
		end
		else begin
			state[4:1] <= state[3:0]; // Shift the previous state values
			state[0] <= state[4] ^ state[2]; // Calculate the next state value
		end
	end

	assign q = state;

endmodule
