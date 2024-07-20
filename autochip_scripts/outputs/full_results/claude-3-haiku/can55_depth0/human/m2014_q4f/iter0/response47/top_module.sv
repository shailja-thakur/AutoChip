module top_module (
    input in1,
    input in2,
    output logic out
);

    // The bubble on the input in2 of the AND gate implies a NOR gate
    assign out = in1 & ~in2;

endmodule
