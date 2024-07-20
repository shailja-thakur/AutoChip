module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    // Generate out_both
    // Each bit in out_both[i] should be 1 if both in[i] and in[i + 1] are 1
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : both_loop
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Generate out_any
    // Each bit in out_any[i] should be 1 if either in[i] or in[i - 1] are 1
    generate
        for (i = 1; i < 100; i = i + 1) begin : any_loop
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate
    
    // Generate out_different
    // Each bit in out_different[i] should be 1 if in[i] is different from in[i - 1]
    // Treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0]
    assign out_different[0] = in[0] ^ in[99]; // Wrapping around for the first bit
    generate
        for (i = 1; i < 100; i = i + 1) begin : different_loop
            assign out_different[i] = in[i] ^ in[i - 1];
        end
    endgenerate

endmodule
