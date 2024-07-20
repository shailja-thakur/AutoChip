module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // (1) out_both
    genvar i;
    generate
        for (i = 0; i < 98; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // (2) out_any
    assign out_any[99:1] = in[99:1] | in[98:0];

    // (3) out_different
    assign out_different[0] = in[0] ^ in[99];
    assign out_different[99:1] = in[99:1] ^ in[98:0];

endmodule
