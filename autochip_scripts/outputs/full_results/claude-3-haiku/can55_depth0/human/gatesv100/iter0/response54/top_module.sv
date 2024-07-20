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
    for (i = 1; i < 100; i = i + 1) begin
        assign out_any[i] = in[i-1] | in[i];
    end

    // out_different
    for (i = 0; i < 100; i = i + 1) begin
        assign out_different[i] = (i == 99) ? (in[i] ^ in[0]) : (in[i] ^ in[i+1]);
    end

endmodule
