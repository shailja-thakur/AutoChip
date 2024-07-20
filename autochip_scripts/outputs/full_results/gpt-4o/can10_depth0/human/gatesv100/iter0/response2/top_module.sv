module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // out_both: Each bit indicates whether both the corresponding input bit and its neighbour to the left are '1'
    generate
        genvar i;
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // out_any: Each bit indicates whether any of the corresponding input bit and its neighbour to the right are '1'
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // out_different: Each bit indicates whether the corresponding input bit is different from its neighbour to the left
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i+1];
        end
        assign out_different[99] = in[99] ^ in[0]; // treating the vector as wrapping around
    endgenerate

endmodule
