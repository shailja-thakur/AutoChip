module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in; // Previous input value

	always @(posedge clk) begin
		prev_in <= in; // Store current input value in previous input
	end

	always @(posedge clk) begin
		// Loop through each bit in the input vector
		for (int i = 0; i < 8; i = i + 1) begin
			// Check for any edge by comparing current and previous bit values
			if (in[i] != prev_in[i]) begin
				// Set the corresponding bit in the output vector on the following cycle
				anyedge[i] <= 1;
			end
		end
	end
endmodule
