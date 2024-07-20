module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
    logic intermediate;

    assign intermediate = ~(in1 ^ in2);
    assign out = intermediate ^ in3;

endmodule
