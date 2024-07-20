module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Register for the counter
	reg [15:0] counter;

	// Assigning the enable signals for the upper three digits
	assign ena = counter[7:5];

	// Synchronous reset logic
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			counter <= 0;
		else
		begin
			if (ena[0])
				counter[3:0] <= counter[3:0] + 1;
			if (ena[1])
				counter[7:4] <= counter[7:4] + 1;
			if (ena[2])
				counter[11:8] <= counter[11:8] + 1;
			if (ena[3])
				counter[15:12] <= counter[15:12] + 1;
		end
	end
	
	// Assigning the counter value to the output
	assign q = counter;

endmodule
