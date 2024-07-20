module top_module (
	input in1,
	input in2,
	output logic out
);
	
	logic in2_bubble;

	// Add a NOT gate to flip the in2 input
	not_gate not1 (
		.in(in2),
		.out(in2_bubble)
	);

	// Implement the AND gate
	and_gate and1 (
		.in1(in1),
		.in2(in2_bubble),
		.out(out)
	);

endmodule
module not_gate (
	input in,
	output logic out
);
	assign out = ~in;
endmodule
module and_gate (
	input in1,
	input in2,
	output logic out
);
	assign out = in1 & in2;
endmodule
