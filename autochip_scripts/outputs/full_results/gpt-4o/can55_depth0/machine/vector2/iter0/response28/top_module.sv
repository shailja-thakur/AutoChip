module top_module (
    input [31:0] in,
    output [31:0] out
);

    assign out[31:24] = in[31:24]; // First 8 bits of input to first 8 bits of output
    assign out[23:16] = in[23:16]; // Second 8 bits of input to second 8 bits of output
    assign out[15:8] = in[15:8];   // Third 8 bits of input to third 8 bits of output
    assign out[7:0] = in[7:0];     // Fourth 8 bits of input to fourth 8 bits of output

endmodule
