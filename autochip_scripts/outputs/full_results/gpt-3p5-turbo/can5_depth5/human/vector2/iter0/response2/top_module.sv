module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Reversing the byte order of the 32-bit vector
    assign out = {in[7:0], in[15:8], in[23:16], in[31:24]};

endmodule
