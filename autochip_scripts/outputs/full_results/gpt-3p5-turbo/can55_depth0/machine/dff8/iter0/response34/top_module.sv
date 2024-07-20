module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);
	initial // set the default value of the output
		q = 8'h0;
	
	always @(posedge clk) // triggered on the rising edge of the clock
	begin
		q <= d; // store the data input in the register
	end
endmodule
