module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate out_both signals
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : both_gen
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Generate out_any signals
    generate
        for (i = 1; i < 100; i = i + 1) begin : any_gen
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Generate out_different signals
    generate
        for (i = 0; i < 100; i = i + 1) begin : different_gen
            if (i == 99) begin
                assign out_different[i] = in[i] ^ in[0];
            end else begin
                assign out_different[i] = in[i] ^ in[i + 1];
            end
        end
    endgenerate

endmodule
