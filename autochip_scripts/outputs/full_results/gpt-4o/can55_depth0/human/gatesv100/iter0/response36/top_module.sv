module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

// out_both: Check if both the corresponding input bit and its left neighbor are '1'
generate
    genvar i;
    for (i = 0; i < 99; i = i + 1) begin : out_both_gen
        assign out_both[i] = in[i] & in[i + 1];
    end
endgenerate

// out_any: Check if either the corresponding input bit or its right neighbor are '1'
generate
    for (i = 1; i < 100; i = i + 1) begin : out_any_gen
        assign out_any[i] = in[i] | in[i - 1];
    end
endgenerate

// out_different: Check if the corresponding input bit is different from its left neighbor
assign out_different[0] = in[0] ^ in[99]; // Wrapping around case for in[99]
generate
    for (i = 1; i < 100; i = i + 1) begin : out_different_gen
        assign out_different[i] = in[i] ^ in[i - 1];
    end
endgenerate

endmodule
