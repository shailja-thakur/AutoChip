module top_module (
	input in1,
	input in2,
	output logic out
);
	logic and_input;
	assign and_input = in2;

	and gates(and_input, in1, out);

endmodule
module and_gate (
	input a,
	input b,
	output logic y
);
	assign y = a & b;
endmodule
