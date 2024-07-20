module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    integer i;

    // Generate out_both
    always @(in) begin
        for (i = 0; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i+1];
        end
    end

    // Generate out_any
    always @(in) begin
        for (i = 1; i < 100; i = i + 1) begin
            out_any[i] = in[i] | in[i-1];
        end
    end

    // Generate out_different
    always @(in) begin
        out_different[0] = in[0] ^ in[99]; // Special case for wrapping around
        for (i = 1; i < 100; i = i + 1) begin
            out_different[i] = in[i] ^ in[i-1];
        end
    end

endmodule
