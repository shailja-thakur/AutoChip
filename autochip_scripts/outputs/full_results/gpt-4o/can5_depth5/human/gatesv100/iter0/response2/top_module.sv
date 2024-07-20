module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // out_both: both the incoming bit and its neighbour to the left are 1
    genvar i;
    generate
        for(i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    
    // out_any: either the incoming bit or its neighbour to the right are 1
    generate
        for(i = 1; i < 100; i = i + 1) begin : out_any_gen
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate
    
    // out_different: the incoming bit is different from its neighbour to the left, wrap around from in[99] to in[0]
    generate
        for(i = 0; i < 99; i = i + 1) begin : out_different_gen
            assign out_different[i] = in[i] ^ in[i+1];
        end
        assign out_different[99] = in[99] ^ in[0]; // wrap around
    endgenerate

endmodule
