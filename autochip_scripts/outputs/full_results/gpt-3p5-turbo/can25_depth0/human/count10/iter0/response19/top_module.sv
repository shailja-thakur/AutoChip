module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	// Internal signal to hold the current count value
	reg [3:0] count;
	
	// Always block to increment the count on each rising edge of the clock
	always @(posedge clk) begin
		// Reset the count to 0 when the reset signal is asserted
		if (reset) begin
			count <= 0;
		end
		// Increment the count by 1 when the reset signal is not asserted
		else begin
			count <= count + 1;
		end
	end
	
	// Assign the value of the count register to the output q
	assign q = count;
	
endmodule
