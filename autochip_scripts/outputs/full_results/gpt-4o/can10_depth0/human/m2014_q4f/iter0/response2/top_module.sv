module top_module (
    input in1,
    input in2,
    output logic out
);

    // Invert in2 before feeding it to the AND gate
    assign out = in1 & ~in2;

endmodule
