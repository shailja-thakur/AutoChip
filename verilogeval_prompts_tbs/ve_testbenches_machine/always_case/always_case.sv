//  This Verilog module is a multiplexer which takes in 6 data inputs (data0-data5) and a selection input (sel) and outputs a single data output (out). The selection input (sel) is a 3-bit number which determines which of the 6 data inputs is selected as the output. If the selection input is 0, then the output will be the data0 input. If the selection input is 1, then the output will be the data1 input, and so on. If the selection input is any other value, then the output will be 0. The output is a 4-bit register which will hold the value of the selected data input until the selection input is changed.

module top_module (
	input [2:0] sel,
	input [3:0] data0,
	input [3:0] data1,
	input [3:0] data2,
	input [3:0] data3,
	input [3:0] data4,
	input [3:0] data5,
	output reg [3:0] out
);
