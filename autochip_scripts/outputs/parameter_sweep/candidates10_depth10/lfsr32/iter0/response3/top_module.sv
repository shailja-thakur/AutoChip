module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Internal signal to hold the state of the LFSR
	reg [31:0] lfsr;

	// Assign the output q to the current state of the LFSR
	assign q = lfsr;

	// Synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			lfsr <= 32'h1; // Reset the LFSR to 32'h1
		end else begin
			// Generate the next state of the LFSR
			lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
		end
	end
endmodule
