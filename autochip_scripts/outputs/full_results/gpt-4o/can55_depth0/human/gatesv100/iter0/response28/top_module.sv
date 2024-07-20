module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    genvar i;
    generate
        // Generating out_both[98:0]
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i + 1];
        end

        // Generating out_any[99:1]
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i - 1];
        end

        // Generating out_different[99:0]
        for (i = 0; i < 100; i = i + 1) begin : gen_out_different
            if (i == 99)
                assign out_different[i] = in[i] ^ in[0];
            else
                assign out_different[i] = in[i] ^ in[i + 1];
        end
    endgenerate

endmodule
