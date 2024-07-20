module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

reg [9:0] counter = 10'b0;
reg tc;

always @(posedge clk) begin
	if (load)
		counter <= data;
	else if (counter == 1'b0)
		counter <= 1'b0;
	else
		counter <= counter - 1;
end

always @(posedge clk) begin
	if (counter == 1'b0)
		tc <= 1'b1;
	else
		tc <= 1'b0;
end

endmodule
