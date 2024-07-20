module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

// (1) out_both
genvar i;
generate
    for (i = 0; i < 99; i = i + 1) begin
        assign out_both[i] = in[i] & in[i+1];
    end
endgenerate

// (2) out_any
genvar j;
generate
    for (j = 0; j < 100; j = j + 1) begin
        assign out_any[j] = (j > 0) ? (in[j] | in[j-1]) : in[j];
    end
endgenerate

// (3) out_different
genvar k;
generate
    for (k = 0; k < 100; k = k + 1) begin
        assign out_different[k] = (k > 0) ? (in[k] ^ in[k-1]) : (in[0] ^ in[99]);
    end
endgenerate

endmodule
