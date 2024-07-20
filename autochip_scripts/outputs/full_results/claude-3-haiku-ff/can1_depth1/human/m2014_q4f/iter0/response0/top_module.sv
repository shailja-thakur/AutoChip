module top_module (
    input in1,
    input in2,
    output logic out
);

// The bubble on the in2 input of the AND gate means it is an NAND gate
assign out = in1 & ~in2;

endmodule
