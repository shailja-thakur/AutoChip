module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    genvar i;
    generate
        // out_both
        for (i = 0; i < 98; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end

        // out_any
        for (i = 1; i < 100; i = i + 1) begin
            assign out_any[i] = in[i-1] | in[i];
        end

        // out_different
        for (i = 0; i < 100; i = i + 1) begin
            assign out_different[i] = in[i] ^ in[(i+1) % 100];
        end
    endgenerate

endmodule
