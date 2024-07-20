module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

reg [9:0] count;
reg tc;
always @(posedge clk) begin
	if (load)
		count <= data;
	else if (count == 0)
		count <= count;
	else
		count <= count - 1;

	if (count == 0)
		tc <= 1;
	else
		tc <= 0;
end	

endmodule
