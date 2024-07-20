module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Compute out_both
    always @* begin
        for (int i = 0; i < 99; i = i + 1) begin
            out_both[i] = (in[i] & in[i+1]);
        end
    end

    // Compute out_any
    always @* begin
        out_any[99] = in[99];
        for (int i = 98; i > 0; i = i - 1) begin
            out_any[i] = (in[i] | in[i-1]);
        end
    end

    // Compute out_different
    always @* begin
        out_different[99] = (in[99] != in[0]);
        for (int i = 98; i >= 0; i = i - 1) begin
            out_different[i] = (in[i] != in[i+1]);
        end
    end

endmodule
