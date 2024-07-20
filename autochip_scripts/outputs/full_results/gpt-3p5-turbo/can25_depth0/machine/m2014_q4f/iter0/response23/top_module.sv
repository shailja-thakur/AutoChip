module top_module (
    input in1,
    input in2,
    output logic out
);

    // Implementation of the logical AND and NOT operation
    assign out = in1 & ~in2;

endmodule
