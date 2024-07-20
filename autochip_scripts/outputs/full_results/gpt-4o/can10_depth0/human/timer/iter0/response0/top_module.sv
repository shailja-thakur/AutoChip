module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

	reg [9:0] counter; // 10-bit internal counter

	always @(posedge clk) begin
		if (load)
			counter <= data; // Load the counter with the given data
		else if (counter != 0)
			counter <= counter - 1; // Decrement the counter if it is not zero
	end

	assign tc = (counter == 0) ? 1'b1 : 1'b0; // Terminal count output

endmodule
