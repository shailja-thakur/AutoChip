module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generating out_both signals
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : generate_out_both
            assign out_both[i] = in[i + 1] & in[i];
        end
    endgenerate

    // Generating out_any signals
    generate
        for (i = 1; i < 100; i = i + 1) begin : generate_out_any
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Generating out_different signals with wrapping around
    generate
        for (i = 0; i < 99; i = i + 1) begin : generate_out_different
            assign out_different[i] = in[i] ^ in[i + 1];
        end
    endgenerate
    assign out_different[99] = in[99] ^ in[0];

endmodule
