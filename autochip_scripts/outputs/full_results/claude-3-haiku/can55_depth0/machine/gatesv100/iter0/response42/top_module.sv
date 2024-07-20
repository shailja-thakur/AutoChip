module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate out_both
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any
    assign out_any = in;

    // Generate out_different
    assign out_different[0] = in[0] ^ in[99];
    genvar j;
    generate
        for (j = 1; j < 100; j = j + 1) begin
            assign out_different[j] = in[j] ^ in[j-1];
        end
    endgenerate

endmodule
