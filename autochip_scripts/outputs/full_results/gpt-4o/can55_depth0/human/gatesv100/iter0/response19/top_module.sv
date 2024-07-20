module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    // Generate out_both[98:0]
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_loop
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any[99:1]
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_loop
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different[99:0]
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_different_loop
            assign out_different[i] = in[i] ^ in[i+1];
        end
        assign out_different[99] = in[99] ^ in[0]; // Wrap around case for in[99]
    endgenerate

endmodule
