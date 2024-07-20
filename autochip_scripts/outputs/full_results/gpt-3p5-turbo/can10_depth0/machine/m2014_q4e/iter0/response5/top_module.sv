module top_module (
    input in1,
    input in2,
    output wire out
);

    // Assign the negation of the logical OR of in1 and in2 to out
    assign out = ~(in1 | in2);

endmodule
