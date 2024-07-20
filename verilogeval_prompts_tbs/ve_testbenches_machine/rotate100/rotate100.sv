//  This Verilog module is a top-level module that is used to shift the bits of the input data. The module has five ports, a clock input (clk), a load input (load), an enable input (ena), a data input (data) and a data output (q).   The clock input (clk) is used to synchronize the module and is used to trigger the state transitions.  The load input (load) is used to control when the data is loaded into the output register (q). When the load input is high, the data input (data) is loaded into the output register (q).  The enable input (ena) is used to control the direction of the shift. When the enable input is set to 2'h1, the output register (q) is shifted to the left. When the enable input is set to 2'h2, the output register (q) is shifted to the right.  The data input (data) is used to provide the data to be shifted. The data input is a 100-bit wide vector.  The data output (q) is used to output the shifted data. The data output is a 100-bit wide vector.  The module is always triggered on the rising edge of the clock input (clk). When the load input is high, the data input (data) is loaded into the output register (q). When the enable input is set to 2'h1, the output register (q) is shifted to the left. When the enable input is set to 2'h2, the output register (q) is shifted to the right.

module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);
