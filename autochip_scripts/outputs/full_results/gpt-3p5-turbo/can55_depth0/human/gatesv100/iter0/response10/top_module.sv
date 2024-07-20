module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);

    integer i;

    always @(in) begin
        for (i = 0; i < 99; i = i + 1) begin
            out_both[i] = (in[i] & in[i+1]);
        end

        for (i = 0; i < 99; i = i + 1) begin
            out_any[i] = (in[i] | in[i+1]);
        end
        out_any[99] = in[98];

        for (i = 0; i < 99; i = i + 1) begin
            out_different[i] = (in[i] != in[i+1]);
        end
        out_different[99] = (in[99] != in[0]);
    end

endmodule
