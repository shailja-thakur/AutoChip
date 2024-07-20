module top_module (
    input in1,
    input in2,
    output logic out
);

	// Perform logical OR of in1 and in2
	assign out = ~(in1 | in2);

endmodule
