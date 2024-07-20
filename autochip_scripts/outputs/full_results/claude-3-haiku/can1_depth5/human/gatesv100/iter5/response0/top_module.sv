module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

// (1) out_both
generate
    genvar i;
    for (i = 0; i < 99; i = i + 1) begin
        assign out_both[i] = in[i] & in[i+1];
    end
endgenerate

// (2) out_any
generate
    for (i = 0; i < 100; i = i + 1) begin
        assign out_any[i] = (i > 0) ? in[i-1] | in[i] : in[0];
    end
endgenerate

// (3) out_different
generate
    for (i = 0; i < 100; i = i + 1) begin
        assign out_different[i] = (i == 0) ? in[0] ^ in[99] : in[i] ^ in[i-1];
    end
endgenerate

endmodule
