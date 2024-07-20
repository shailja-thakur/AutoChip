module top_module (
    input in1,
    input in2,
    output logic out
);

    // implementation of the logical negation of the logical OR
    assign out = ~(in1 | in2);

endmodule
