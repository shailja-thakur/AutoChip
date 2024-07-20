module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] d_last;      // Register to store the previous value of the input signal
	
	always @(posedge clk) begin
		d_last <= in;          // Store current value of input signal in d_last register
		pedge <= in & (~d_last);    // Calculate pedge by performing bitwise AND between input signal and inverse of d_last
	end
	
endmodule
