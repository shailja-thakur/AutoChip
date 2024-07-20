module top_module (
    input in1,
    input in2,
    output logic out
);

    // The output signal `out` should be the logical negation of the logical OR of the two input signals `in1` and `in2`.
    assign out = ~(in1 | in2);

endmodule
