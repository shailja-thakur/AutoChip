module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge
);
	reg [7:0] d_last; // register to store the value of the input signal from the previous clock cycle

	always @(posedge clk) begin
		d_last <= in; // store the current value of the 8-bit input signal in the d_last register
		pedge <= in & ~d_last; // calculate the output signal by performing a bitwise AND operation between the current value of the 8-bit input signal and the inverse of the value stored in the d_last register
	end
endmodule
