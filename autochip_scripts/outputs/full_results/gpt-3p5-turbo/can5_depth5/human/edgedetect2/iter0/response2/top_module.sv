module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	// Declare a temporary register to store the previous value of the input signal
	reg [7:0] prev_in;
	
	// Always block sensitive to rising edge of clk
	always @(posedge clk) begin
		// Loop through each bit in the vector
		for (integer i = 0; i < 8; i = i + 1) begin
			// Check if the current bit has changed from the previous cycle
			if (in[i] != prev_in[i]) begin
				// If the current bit has changed from 0 to 1, set the output bit
				if (in[i] == 1'b1) begin
					anyedge[i] <= 1'b1;
				end
			end
		end
		// Store the current value of in into prev_in
		prev_in <= in;
	end
endmodule
