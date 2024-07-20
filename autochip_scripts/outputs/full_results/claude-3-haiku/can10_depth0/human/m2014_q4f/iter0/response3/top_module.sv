module top_module (
    input in1,
    input in2,
    output logic out
);

    // The input in2 has a bubble, which means it is inverted before going into the AND gate.
    // To implement this, we can use the negation operator '~' on in2.
    assign out = in1 & ~in2;

endmodule
