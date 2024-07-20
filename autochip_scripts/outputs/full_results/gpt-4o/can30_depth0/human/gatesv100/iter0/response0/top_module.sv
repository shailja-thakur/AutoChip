module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    
    // out_both: in[i] and in[i+1] should both be 1 (excluding the last bit)
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin: out_both_gen
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    
    // out_any: in[i] or in[i-1] should be 1 (excluding the first bit)
    generate
        for (i = 1; i < 100; i = i + 1) begin: out_any_gen
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate
    
    // out_different: in[i] is different from its left neighbor
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin: out_different_gen
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate
    
endmodule
