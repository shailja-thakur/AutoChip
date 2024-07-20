module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Define a signal for the counter
	reg [9:0] counter;
	
	// Define a signal for the next counter value
	reg [9:0] next_counter;
	
	// Assign the tc output port based on the counter value
	assign tc = (counter == 0);
	
	// Always block triggered on the rising edge of the clk signal
	always @(posedge clk) begin
		// If the load input signal is asserted, load the new value from data
		if (load) begin
			next_counter <= data;
		end
		// If the counter is not already at 0, decrement the counter by 1
		else if (counter != 0) begin
			next_counter <= counter - 1;
		end
	end
	
	// Assign the next_counter value to the counter
	always @(posedge clk) begin
		counter <= next_counter;
	end
endmodule
