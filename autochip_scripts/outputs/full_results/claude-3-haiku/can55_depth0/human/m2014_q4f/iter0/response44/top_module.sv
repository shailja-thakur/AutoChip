module top_module (
    input in1,
    input in2,
    output logic out
);

    // The AND gate with the bubble on the in2 input is equivalent to a NAND gate
    assign out = in1 & ~in2;

endmodule
