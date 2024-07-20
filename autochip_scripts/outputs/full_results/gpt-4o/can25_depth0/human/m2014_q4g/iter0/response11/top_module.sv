module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
    logic xn;

    // XNOR Gate
    assign xn = ~(in1 ^ in2);

    // XOR Gate
    assign out = xn ^ in3;

endmodule
