module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Declare a register to store the value of the counter
	reg [9:0] counter;

	// Declare a wire to connect the comparison result to the tc port
	wire tc;

	// Assign the tc wire to the comparison result between the counter value and 0
	assign tc = (counter == 0);

	// Always block triggered on the rising edge of clk
	always @(posedge clk) begin
		// If the load port is asserted, then load the counter with the value from the data port
		// Otherwise, if the counter is not already at 0, then decrement the counter by 1
		if (load) begin
			counter <= data;
		end else if (counter != 0) begin
			counter <= counter - 1;
		end
	end
endmodule
