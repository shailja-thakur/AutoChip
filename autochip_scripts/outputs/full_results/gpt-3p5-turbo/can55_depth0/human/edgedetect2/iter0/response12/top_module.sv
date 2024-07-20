module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	// Register to store previous input value
	reg [7:0] prev_in;

	// Process the input signal on every positive edge of the clock
	always @(posedge clk) begin
		// Loop through each bit of the input vector
		for (integer i = 0; i < 8; i = i + 1) begin
			// Check if the current bit is different from the previous value
			if (in[i] != prev_in[i]) begin
				// Update the anyedge register on the next cycle
				anyedge[i] <= 1;
			end else begin
				anyedge[i] <= 0;
			end
		end

		// Store the current input value for the next cycle
		prev_in <= in;
	end
endmodule
