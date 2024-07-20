module top_module (
    input [31:0] in,
    output [31:0] out
);

    // The first 8 bits of the input are assigned to the first 8 bits of the output
    assign out[31:24] = in[31:24];

    // The second 8 bits of the input are assigned to the second 8 bits of the output
    assign out[23:16] = in[23:16];

    // The third 8 bits of the input are assigned to the third 8 bits of the output
    assign out[15:8] = in[15:8];

    // The fourth 8 bits of the input are assigned to the fourth 8 bits of the output
    assign out[7:0] = in[7:0];

endmodule
