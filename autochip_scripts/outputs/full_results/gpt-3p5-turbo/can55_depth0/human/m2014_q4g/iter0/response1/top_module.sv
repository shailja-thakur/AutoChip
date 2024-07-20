module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

xor #(2) X1 (
    .a(in1),
    .b(in2),
    .out(out_xor)
);

xnor #(2) X2 (
    .a(in1),
    .b(in2),
    .out(in_xnor)
);

xor #(2) X3 (
    .a(in_xnor),
    .b(in3),
    .out(out)
);

endmodule
