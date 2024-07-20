module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Internal signal and register
	reg [9:0] counter;
	
	// Always block to handle counter logic
	always @(posedge clk) begin
		// If load = 1, load the internal counter with the data
		if (load) begin
			counter <= data;
		end
		// If load = 0, decrement the internal counter by 1
		else begin
			if (counter > 0) begin
				counter <= counter - 1;
			end
		end
	end
	
	// Output terminal count signal
	assign tc = (counter == 0);
endmodule
