module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    
    // Generating out_both: both corresponding bit and its left neighbour are '1'
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    
    // Generating out_any: any of the corresponding bit and its right neighbour are '1'
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_gen
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate
    
    // Generating out_different: bit is different from its left neighbour (wrapping around)
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_different_gen
            assign out_different[i] = in[i] ^ in[i+1];
        end
    endgenerate
    assign out_different[99] = in[99] ^ in[0]; // Wrapping around

endmodule
