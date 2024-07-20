module top_module (
    input in1,
    input in2,
    output logic out
);

    // Assign the negation of the logical OR of the two input signals to the output
    assign out = ~(in1 | in2);

endmodule
