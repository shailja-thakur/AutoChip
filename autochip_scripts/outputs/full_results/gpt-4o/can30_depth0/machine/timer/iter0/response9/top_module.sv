module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc
);

	// Counter register
	reg [9:0] counter;
	
	always @(posedge clk) begin
		if (load) begin
			// Load new value into counter
			counter <= data;
		end else if (counter != 0) begin
			// Decrement counter if not zero
			counter <= counter - 1;
		end
	end
	
	// Generate terminal count output
	always @(*) begin
		if (counter == 0) begin
			tc = 1;
		end else begin
			tc = 0;
		end
	end

endmodule
