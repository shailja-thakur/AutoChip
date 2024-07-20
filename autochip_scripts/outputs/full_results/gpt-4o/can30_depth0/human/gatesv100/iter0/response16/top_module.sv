module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Compute out_both: Each bit should indicate whether both the 
    // corresponding input bit and its neighbour to the left are '1'.
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : generate_out_both
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Compute out_any: Each bit should indicate whether any of the 
    // corresponding input bit and its neighbour to the right are '1'.
    generate
        for (i = 1; i < 100; i = i + 1) begin : generate_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Compute out_different: Each bit should indicate whether the 
    // corresponding input bit is different from its neighbour to the left.
    generate
        for (i = 0; i < 99; i = i + 1) begin : generate_out_different
            assign out_different[i] = in[i] ^ in[i+1];
        end
        // For wrapping around, in[99]'s neighbour to the left is in[0]
        assign out_different[99] = in[99] ^ in[0];
    endgenerate

endmodule
