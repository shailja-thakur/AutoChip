module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);

    always @(in) begin
        out_both = in[98:0] & in[97:0];
        out_any = in | (in << 1);
        out_different[0] = in[99] ^ in[98];
        out_different[99:1] = in[98:0] ^ (in[97:0] << 1);
    end

endmodule
