module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	reg [9:0] count;
	always @(posedge clk) begin
		if (load)
			count <= data;
		else if (count != 0) // Added condition to prevent decrementing when count is already 0
			count <= count - 1;
	end
	assign tc = (count == 0);
endmodule
