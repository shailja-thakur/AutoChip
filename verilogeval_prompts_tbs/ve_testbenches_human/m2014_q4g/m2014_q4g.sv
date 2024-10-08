// Implement in Verilog the following circuit: A two-input XNOR (connected to 'in1' and 'in2) has an output connected to the input of a two-input XOR. The second input of the XOR is 'in3.' The output of the XOR is 'out'.

module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
