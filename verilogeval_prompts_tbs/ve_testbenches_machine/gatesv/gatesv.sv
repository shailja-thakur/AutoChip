// This Verilog module is a top-level module that is used to evaluate a variety of bitwise functions. The module has six ports, an input (in), an output for the bitwise AND operation (out_both), an output for the bitwise OR operation (out_any), and an output for the bitwise XOR operation (out_different).  The input (in) is used to provide the data to be evaluated. The input is a 4-bit wide vector.  The output for the bitwise AND operation (out_both) is used to output the result of the bitwise AND operation. The output is a 3-bit wide vector.  The output for the bitwise OR operation (out_any) is used to output the result of the bitwise OR operation. The output is a 4-bit wide vector.  The output for the bitwise XOR operation (out_different) is used to output the result of the bitwise XOR operation. The output is a 4-bit wide vector.  The output for the bitwise AND operation (out_both) is assigned to the result of a bitwise AND operation between the input (in) vector bits 2 through 0 and the input (in) vector bits 3 through 1. The output for the bitwise OR operation (out_any) is assigned to the result of a bitwise OR operation between the input (in) vector bits 2 through 0 and the input (in) vector bits 3 through 1.  The output for the bitwise XOR operation (out_different) is assigned to the result of a bitwise XOR operation between the input (in) vector and the input (in) vector bits 3 through 1 with the input (in) vector bit 0 as an exception.




module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
