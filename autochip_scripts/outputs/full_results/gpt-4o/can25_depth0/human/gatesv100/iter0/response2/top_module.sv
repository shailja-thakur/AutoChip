module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // (1) out_both calculation
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // (2) out_any calculation
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // (3) out_different calculation
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i + 1];
        end
    endgenerate
    assign out_different[99] = in[99] ^ in[0];

endmodule
