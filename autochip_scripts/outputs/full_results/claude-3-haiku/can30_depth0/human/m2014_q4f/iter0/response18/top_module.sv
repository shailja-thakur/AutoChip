module top_module (
    input in1,
    input in2,
    output logic out
);

    // The input in2 has a bubble, which means it is an active-low input
    // To connect it to an AND gate, we need to invert the input
    logic in2_inverted;
    assign in2_inverted = ~in2;

    // Now we can connect the AND gate
    assign out = in1 & in2_inverted;

endmodule
