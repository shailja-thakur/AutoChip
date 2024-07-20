module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

always @(posedge clk or posedge areset)
begin
	if(areset)
		q <= 4'b0000; // set output register to 0 when asynchronous reset is active
	else if(load)
		q <= data; // load data input into output register when load signal is active
	else if(ena)
		q <= {q[2:0],1'b0}; // shift output register left by 1 bit when enable signal is active
end

endmodule
