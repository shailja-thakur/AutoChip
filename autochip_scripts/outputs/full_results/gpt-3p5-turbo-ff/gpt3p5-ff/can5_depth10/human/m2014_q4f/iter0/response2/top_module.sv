module top_module (
	input in1,
	input in2,
	output logic out
);
	
	and gate1 (
		.in1(in1),
		.in2(~in2),
		.out(out)
	);
	
endmodule
