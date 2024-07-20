module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Declare the counter signal
	reg [9:0] counter;

	always @(posedge clk) begin
		// Check if load is asserted
		if (load) begin
			// Load the counter with the value from the data port
			counter <= data;
		end
		else if (counter != 0) begin
			// Decrement the counter by 1 if it is not already at 0
			counter <= counter - 1;
		end
		// Assign the tc port based on the counter value
		tc <= (counter == 0);
	end
endmodule
