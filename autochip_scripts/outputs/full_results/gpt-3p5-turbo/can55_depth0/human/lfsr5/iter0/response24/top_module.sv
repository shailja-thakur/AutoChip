module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define the state variable for the LFSR
	reg [4:0] state;

	// Define the taps for the Galois LFSR
	parameter TAP_1 = 5;
	parameter TAP_2 = 3;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 5'b1;
		end else begin
			// Calculate the next state of the LFSR
			state <= {state[3:0], state[TAP_1] ^ state[TAP_2]};
		end
	end

	// Assign the LFSR output to the output port
	assign q = state;

endmodule
