module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Assign the output to the input bits rearranged in 8-bit chunks
    assign out = {in[31:24], in[23:16], in[15:8], in[7:0]};

endmodule
