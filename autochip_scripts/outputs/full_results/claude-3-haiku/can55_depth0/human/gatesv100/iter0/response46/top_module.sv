module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // out_both
    genvar i;
    generate
        for (i = 0; i < 98; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // out_any
    for (int j = 1; j < 100; j = j + 1) begin
        assign out_any[j] = in[j-1] | in[j];
    end

    // out_different
    for (int k = 0; k < 100; k = k + 1) begin
        assign out_different[k] = in[k] ^ in[(k+1) % 100];
    end

endmodule
