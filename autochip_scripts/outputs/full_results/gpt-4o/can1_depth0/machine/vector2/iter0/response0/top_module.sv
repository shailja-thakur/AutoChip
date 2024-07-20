module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Rearrange the 32-bit input into 8-bit chunks in the same order
    assign out[7:0] = in[7:0];
    assign out[15:8] = in[15:8];
    assign out[23:16] = in[23:16];
    assign out[31:24] = in[31:24];

endmodule
