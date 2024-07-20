module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal signal to hold the current value of the counter
	reg [3:0] count;

	always @(posedge clk) begin
		// Check if the reset signal is asserted
		if (reset) begin
			count <= 4'b0; // Reset the counter to 0
		else begin
			// Increment the counter
			if (count == 4'b1111)
				count <= 4'b0;
			else
				count <= count + 1;
		end
	end

	// Assign the counter value to the output
	assign q = count;

endmodule
