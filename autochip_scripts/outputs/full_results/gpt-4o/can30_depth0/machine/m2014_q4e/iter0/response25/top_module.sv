module top_module (
    input in1,
    input in2,
    output logic out
);

    // assign out to the negation of the OR of in1 and in2
    assign out = ~(in1 | in2);

endmodule
