module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Declare counter register
	reg [9:0] counter;

	// Synchronous process
	always @(posedge clk) begin
		if (load) begin
			counter <= data;  // Load new value into counter
		end else if (counter != 0) begin
			counter <= counter - 1;  // Decrement counter
		end
	end

	// Assign the terminal count output
	assign tc = (counter == 0);

endmodule
