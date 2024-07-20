module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate out_both: Each bit indicates whether both the corresponding input bit and its neighbour to the left are '1'
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any: Each bit indicates whether any of the corresponding input bit and its neighbour to the right are '1'
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different: Each bit indicates whether the corresponding input bit is different from its neighbour to the left
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate
    
endmodule
