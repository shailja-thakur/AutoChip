module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Declare a reg variable to store the counter value
	reg [9:0] counter;
	
	// Always block triggered by the posedge of the clk signal
	always @(posedge clk)
	begin
		// Check if load is asserted, if true, assign the data value to the counter
		if (load)
			counter <= data;
		// Check if counter is not already at 0, if true, decrement the counter by 1
		else if (counter != 0)
			counter <= counter - 1;
	end
	
	// Assign tc the result of the comparison between counter and 0
	assign tc = (counter == 0);
endmodule
