module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Internal counter to keep track of the time
	reg [9:0] counter;
	// Output signal indicating that the duration has elapsed
	reg tc;

	always @(posedge clk) begin
		// If load = 1, load the internal counter with the data
		if(load) begin
			counter <= data;
		end
		// If load = 0, decrement the internal counter by 1
		else begin
			if(counter > 0) begin
				counter <= counter - 1;
			end
		end
	end

	// Output signal tc is asserted when counter reaches 0
	assign tc = (counter == 0);

endmodule
