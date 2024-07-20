module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Internal counter
	reg [9:0] counter;

	// Output signal
	assign tc = (counter == 0);

	// Clock behavior
	always @(posedge clk)
		if (load)
			counter <= data;
		else if (counter != 0)
			counter <= counter - 1;

endmodule
