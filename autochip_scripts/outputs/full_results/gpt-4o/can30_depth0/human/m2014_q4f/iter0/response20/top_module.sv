module top_module (
	input in1,
	input in2,
	output logic out
);
    // in2 is inverted and passed to the AND gate
    assign out = in1 & ~in2;
endmodule
