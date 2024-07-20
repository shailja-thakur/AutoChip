module top_module (
    input in1,
    input in2,
    output logic out
);

    // The bubble indicates that the in2 input to the AND gate is active low
    assign out = in1 & ~in2;

endmodule
