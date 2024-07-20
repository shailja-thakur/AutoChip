module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc
);

	reg [9:0] counter;

	always @(posedge clk) begin
		if (load) begin
			// Load the counter with data when load is high
			counter <= data;
		end
		else if (counter != 0) begin
			// Decrement the counter if it is not zero
			counter <= counter - 1;
		end
		
		// Update the terminal count output signal
		tc <= (counter == 0);
	end

endmodule
