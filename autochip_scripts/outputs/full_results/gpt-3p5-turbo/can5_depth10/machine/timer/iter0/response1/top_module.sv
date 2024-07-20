module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc // Add 'reg' keyword before tc to make it a reg type output
);

	reg [9:0] counter; // Declare a reg type variable for the counter
	
	always @(posedge clk) // Trigger the always block on the rising edge of clk
	begin
		if (load) // Check if load is asserted
			counter <= data; // Load the value from the data port into counter
		else if (counter != 0) // Check if counter is not already at 0
			counter <= counter - 1; // Decrement the counter by 1
		
		tc <= (counter == 0); // Assign tc the result of the comparison between counter and 0
	end
	
endmodule
