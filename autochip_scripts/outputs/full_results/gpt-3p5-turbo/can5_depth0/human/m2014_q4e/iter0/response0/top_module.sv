module top_module (
	input in1,
	input in2,
	output logic out
);
	assign out = ~(in1 | in2);  // Implementing 2-input NOR gate using bitwise OR and bitwise negation.
endmodule
