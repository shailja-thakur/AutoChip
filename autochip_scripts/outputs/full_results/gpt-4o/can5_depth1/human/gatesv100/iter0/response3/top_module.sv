module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    genvar i;

    // Generate out_both: checks if both input bit and its left neighbor are 1
    generate 
        for (i = 0; i < 99; i = i + 1) begin: out_both_block
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any: checks if either input bit or its right neighbor are 1
    generate 
        for (i = 1; i < 100; i = i + 1) begin: out_any_block
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different: checks if input bit and its left neighbor are different
    generate 
        for (i = 0; i < 99; i = i + 1) begin: out_different_block
            assign out_different[i] = in[i] ^ in[i+1];
        end
    endgenerate
    assign out_different[99] = in[99] ^ in[0];  // Wrapping around case

endmodule
