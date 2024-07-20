module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    integer i;

    // Compute out_both
    always @(*) begin
        for (i = 0; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i + 1];
        end
    end

    // Compute out_any
    always @(*) begin
        for (i = 1; i < 100; i = i + 1) begin
            out_any[i] = in[i] | in[i - 1];
        end
    end

    // Compute out_different with wrap-around
    always @(*) begin
        for (i = 0; i < 99; i = i + 1) begin
            out_different[i] = in[i] ^ in[i + 1];
        end
        out_different[99] = in[99] ^ in[0]; // Wrap-around condition
    end

endmodule
