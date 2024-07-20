module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

reg [9:0] counter;
reg tc;

always @(posedge clk) begin
	if (load)
		counter <= data;
	else if (!counter)
		tc <= 1'b1;
	else
		counter <= counter - 1;
end

endmodule
