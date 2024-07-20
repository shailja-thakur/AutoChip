module top_module (
    input in1,
    input in2,
    output logic out
);

    // The input in2 has a bubble, which means it is an active-low input
    // Therefore, we need to invert the input before connecting it to the AND gate
    assign out = in1 & ~in2;

endmodule
