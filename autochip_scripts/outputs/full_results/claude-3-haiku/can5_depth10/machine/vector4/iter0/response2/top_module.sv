module top_module (
    input [7:0] in,
    output [31:0] out
);

    // Concatenate the replicated 8-bit input with the original 8-bit input
    assign out = {in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0], in[7:0]};

endmodule
