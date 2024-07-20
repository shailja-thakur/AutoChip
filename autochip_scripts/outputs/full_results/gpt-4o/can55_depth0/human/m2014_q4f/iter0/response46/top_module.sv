module top_module (
	input in1,
	input in2,
	output logic out
);
	// Inverting in2 and then performing the AND operation
	assign out = in1 & ~in2;
endmodule
