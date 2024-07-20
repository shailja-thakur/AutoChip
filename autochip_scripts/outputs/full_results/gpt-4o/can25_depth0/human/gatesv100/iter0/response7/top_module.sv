module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generating out_both which is true if both the bit and its left neighbor are '1'
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Generating out_any which is true if any of the bit and its right neighbor are '1'
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Generating out_different which is true if the bit is different from its left neighbor in a circular manner
    generate
        for (i = 0; i < 100; i = i + 1) begin : gen_out_different
            if (i == 0) begin
                assign out_different[i] = in[i] ^ in[99];
            end else begin
                assign out_different[i] = in[i] ^ in[i - 1];
            end
        end
    endgenerate

endmodule
