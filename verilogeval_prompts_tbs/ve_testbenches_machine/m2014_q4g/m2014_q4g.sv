//  This Verilog module takes three inputs, in1, in2, and in3, and produces a single output, out. The output is calculated by performing a bitwise XOR operation on in1 and in2, and then performing a bitwise NOT operation on the result, followed by another bitwise XOR operation with in3. In other words, the output is equal to (NOT (in1 XOR in2)) XOR in3.

module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
