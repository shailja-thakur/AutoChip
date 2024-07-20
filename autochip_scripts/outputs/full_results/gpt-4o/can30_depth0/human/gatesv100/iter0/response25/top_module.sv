module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    // Generate output for out_both
    generate
        genvar i;
        for (i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    
    // Generate output for out_any
    generate
        genvar j;
        for (j = 1; j < 100; j = j + 1) begin : out_any_gen
            assign out_any[j] = in[j] | in[j-1];
        end
    endgenerate
    
    // Generate output for out_different
    generate
        genvar k;
        for (k = 0; k < 99; k = k + 1) begin : out_different_gen
            assign out_different[k] = in[k] ^ in[k+1];
        end
        assign out_different[99] = in[99] ^ in[0];
    endgenerate
    
endmodule
