module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    generate
        genvar i;
        // Generate out_both
        for (i = 0; i < 99; i = i + 1) begin : both_loop
            assign out_both[i] = in[i] & in[i + 1];
        end

        // Generate out_any
        for (i = 1; i < 100; i = i + 1) begin : any_loop
            assign out_any[i] = in[i] | in[i - 1];
        end

        // Generate out_different
        for (i = 0; i < 99; i = i + 1) begin : different_loop
            assign out_different[i] = in[i] ^ in[i + 1];
        end
        assign out_different[99] = in[99] ^ in[0];
    endgenerate

endmodule
