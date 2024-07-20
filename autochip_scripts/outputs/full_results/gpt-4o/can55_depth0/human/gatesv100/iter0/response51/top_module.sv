module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Assignment for out_both (Each bit of this output vector should indicate whether both 
    // the corresponding input bit and its neighbour to the left are '1')
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_assign
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Assignment for out_any (Each bit of this output vector should indicate whether any 
    // of the corresponding input bit and its neighbour to the right are '1')
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_assign
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Assignment for out_different (Each bit of this output vector should indicate whether 
    // the corresponding input bit is different from its neighbour to the left)
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_different_assign
            assign out_different[i] = in[i] ^ in[i + 1];
        end
        // For the wrap-around case
        assign out_different[99] = in[99] ^ in[0];
    endgenerate

endmodule
