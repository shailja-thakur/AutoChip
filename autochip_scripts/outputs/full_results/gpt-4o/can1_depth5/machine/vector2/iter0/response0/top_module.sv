module top_module (
    input [31:0] in,
    output [31:0] out
);
    assign out[7:0] = in[31:24];       // Assign the first 8 bits of output to the last 8 bits of input
    assign out[15:8] = in[23:16];      // Assign the second 8 bits of output to the third 8 bits of input
    assign out[23:16] = in[15:8];      // Assign the third 8 bits of output to the second 8 bits of input
    assign out[31:24] = in[7:0];       // Assign the last 8 bits of output to the first 8 bits of input
endmodule
