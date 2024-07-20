module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

    submodule1 sub1 (
        .in1(in1),
        .in2(in2),
        .out1(xnor_out)
    );

    submodule2 sub2 (
        .in1(xnor_out),
        .in2(in3),
        .out2(out)
    );

endmodule
module submodule1 (
	input in1,
	input in2,
	output logic out1
);

    assign out1 = ~(in1 ^ in2);

endmodule
module submodule2 (
	input in1,
	input in2,
	output logic out2
);

    assign out2 = in1 ^ in2;

endmodule
