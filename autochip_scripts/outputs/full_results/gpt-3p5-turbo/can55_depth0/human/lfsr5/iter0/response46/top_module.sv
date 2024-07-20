module top_module (
	input clk,
	input reset,
	output reg [4:0] q
);
	
	// Register for storing the LFSR state
	reg [4:0] lfsr_state;
	
	// Tap positions for the LFSR
	parameter TAP_1 = 3;
	parameter TAP_2 = 5;

	// Always block for updating the LFSR state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr_state <= 5'b00001;
		end else begin
			lfsr_state <= {lfsr_state[TAP_1-1] ^ lfsr_state[TAP_2-1], lfsr_state[3:1]};
		end
	end
	
	// Assign the output of the LFSR to the output wire
	assign q = lfsr_state;
endmodule
