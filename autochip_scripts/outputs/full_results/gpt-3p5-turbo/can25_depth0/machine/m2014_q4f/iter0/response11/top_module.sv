module top_module (
    input wire in1,
    input wire in2,
    output wire out
);

    // Correction: Use `assign` for continuous assignment
    assign out = in1 & (~in2);

endmodule
