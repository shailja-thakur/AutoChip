module top_module (
    input in1,
    input in2,
    output logic out
);

    // Implement the logical negation of the logical OR of the two input signals
    assign out = ~(in1 | in2);

endmodule
