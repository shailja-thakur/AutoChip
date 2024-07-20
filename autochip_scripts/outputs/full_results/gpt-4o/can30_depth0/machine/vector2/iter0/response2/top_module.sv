module top_module (
    input [31:0] in,
    output [31:0] out
);
    assign out[31:24] = in[7:0];  // The first 8 bits of the input (in[7:0]) assigned to the last 8 bits of the output (out[31:24])
    assign out[23:16] = in[15:8]; // The second 8 bits of the input (in[15:8]) assigned to the second last 8 bits of the output (out[23:16])
    assign out[15:8] = in[23:16]; // The third 8 bits of the input (in[23:16]) assigned to the second 8 bits of the output (out[15:8])
    assign out[7:0] = in[31:24];  // The last 8 bits of the input (in[31:24]) assigned to the first 8 bits of the output (out[7:0])
endmodule
