module top_module (
    input in1,
    input in2,
    output logic out
);

    // The bubble on the in2 input means it is an active-low input, so we need to invert it before feeding it to the AND gate.
    assign out = in1 & ~in2;

endmodule
