module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate out_both: out_both[n] = (in[n] & in[n+1]) for n in range[0:98]
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin
            if (i <= 98) begin
                assign out_both[i] = in[i] & in[i+1];
            end
        end
    endgenerate

    // Generate out_any: out_any[n] = (in[n] | in[n-1]) for n in range[1:99]
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different: out_different[n] = (in[n] ^ in[n-1]) for n in range[0:99], with wrap-around for in[99]
    generate
        for (i = 0; i < 100; i = i + 1) begin
            if (i == 0) begin
                assign out_different[i] = in[i] ^ in[99];  // wrap around for in[0]
            end else begin
                assign out_different[i] = in[i] ^ in[i-1];
            end
        end
    endgenerate

endmodule
