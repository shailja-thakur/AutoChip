module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// Internal counter wire
	wire [9:0] counter;
	
	// Timer down-counter
	always @(posedge clk) begin
		if (load)
			counter <= data;
		else if (counter > 0)
			counter <= counter - 1;
	end
	
	// Output signal tc
	assign tc = (counter == 0);
endmodule
