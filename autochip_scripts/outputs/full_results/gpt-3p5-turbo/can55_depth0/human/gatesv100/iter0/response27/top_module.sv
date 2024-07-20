module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // (1) out_both
    assign out_both[0] = in[0] & in[99];
    generate
        genvar i;
        for (i = 1; i <= 98; i = i + 1) begin : out_both_loop
            assign out_both[i] = in[i] & in[i-1];
        end
    endgenerate
    
    // (2) out_any
    assign out_any[99] = in[98] | in[99];
    generate
        genvar j;
        for (j = 1; j <= 98; j = j + 1) begin : out_any_loop
            assign out_any[j] = in[j] | in[j+1];
        end
    endgenerate
    
    // (3) out_different
    assign out_different[0] = in[0] != in[99];
    generate
        genvar k;
        for (k = 1; k <= 99; k = k + 1) begin : out_different_loop
            assign out_different[k] = in[k] != in[k-1];
        end
    endgenerate
    
endmodule
