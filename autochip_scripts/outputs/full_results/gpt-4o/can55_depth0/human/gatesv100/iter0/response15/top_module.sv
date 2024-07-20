module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // out_both: Each bit of this output vector should indicate whether both
    // the corresponding input bit and its neighbour to the left are '1'.
    genvar i_both;
    generate
        for (i_both = 0; i_both < 99; i_both = i_both + 1) begin : both_loop
            assign out_both[i_both] = in[i_both] & in[i_both+1];
        end
    endgenerate

    // out_any: Each bit of this output vector should indicate whether any of
    // the corresponding input bit and its neighbour to the right are '1'.
    genvar i_any;
    generate
        for (i_any = 1; i_any < 100; i_any = i_any + 1) begin : any_loop
            assign out_any[i_any] = in[i_any] | in[i_any-1];
        end
    endgenerate

    // out_different: Each bit of this output vector should indicate whether
    // the corresponding input bit is different from its neighbour to the left.
    // Treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0].
    genvar i_diff;
    generate
        for (i_diff = 0; i_diff < 100; i_diff = i_diff + 1) begin : diff_loop
            if (i_diff == 99) begin
                assign out_different[i_diff] = in[i_diff] ^ in[0];
            end else begin
                assign out_different[i_diff] = in[i_diff] ^ in[i_diff+1];
            end
        end
    endgenerate

endmodule
