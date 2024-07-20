module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by 1 bit
    wire [99:0] in_shifted = {in[98:0], 1'b0};

    // Bit-wise AND between the input vector and the shifted vector
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in_shifted[i];
        end
    endgenerate

    // Bit-wise OR between the input vector and the shifted vector
    assign out_any = in | in_shifted;

    // Bit-wise XOR between the input vector and the shifted vector
    assign out_different[99] = in[99] ^ in_shifted[98];
    genvar j;
    generate
        for (j = 0; j < 99; j = j + 1) begin
            assign out_different[j] = in[j] ^ in_shifted[j];
        end
    endgenerate

endmodule
