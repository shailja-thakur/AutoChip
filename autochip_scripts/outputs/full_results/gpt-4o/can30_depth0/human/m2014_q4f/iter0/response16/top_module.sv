module top_module (
    input in1,
    input in2,
    output logic out
);

    // In2 bubble means it is inverted before AND gate
    assign out = in1 & ~in2;

endmodule
