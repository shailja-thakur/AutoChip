module top_module (
    input in1,
    input in2,
    output logic out
);

    // Assign the output to the logical negation of the logical OR of in1 and in2
    assign out = ~(in1 | in2);

endmodule
