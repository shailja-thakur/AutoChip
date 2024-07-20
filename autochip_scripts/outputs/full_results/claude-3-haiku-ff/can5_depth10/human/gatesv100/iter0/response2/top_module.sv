module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

// (1) out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left are '1'.
generate
    genvar i;
    for (i = 0; i < 98; i = i + 1) begin
        assign out_both[i] = in[i] & in[i+1];
    end
endgenerate

// (2) out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'.
generate
    for (i = 1; i < 100; i = i + 1) begin
        assign out_any[i] = in[i-1] | in[i];
    end
endgenerate

// (3) out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left.
// For this part, treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0].
assign out_different[0] = in[0] ^ in[99];
generate
    for (i = 1; i < 100; i = i + 1) begin
        assign out_different[i] = in[i] ^ in[i-1];
    end
endgenerate

endmodule
