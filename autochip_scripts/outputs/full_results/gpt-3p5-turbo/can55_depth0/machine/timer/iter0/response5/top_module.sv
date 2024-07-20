module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Define the counter signal
	reg [9:0] counter;
	
	// Always block triggered by the positive edge of clk
	always @(posedge clk) begin
		if (load) begin
			// Load the counter with value from data
			counter <= data;
		end else if (counter != 0) begin
			// Decrement the counter by 1 if not already at 0
			counter <= counter - 1;
		end
	end
	
	// Assign tc as the comparison result between counter and 0
	assign tc = (counter == 0);
endmodule
