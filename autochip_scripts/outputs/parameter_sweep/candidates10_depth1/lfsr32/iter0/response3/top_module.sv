module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Internal reg to hold the state of the LFSR
	reg [31:0] lfsr_state;
	
	// Combinational logic to generate the next state of the LFSR
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr_state <= 32'h1; // Reset the state to 32'h1
		end else begin
			lfsr_state <= {lfsr_state[30:0], lfsr_state[21] ^ lfsr_state[1] ^ lfsr_state[0]}; // Shift the state and calculate the next bit
		end
	end
	
	// Assign the output q to the current state of the LFSR
	assign q = lfsr_state;
 
endmodule
