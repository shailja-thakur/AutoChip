module top_module (
    input in1,
    input in2,
    output logic out
);

    // in2 input has a bubble, which means it's inverted before the AND gate
    assign out = in1 & ~in2;

endmodule
