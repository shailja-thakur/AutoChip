module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);

    always @* begin
        out_both = {in[98], in[97:0]} & {in[98:0], in[99]};
        out_any = {in[99], in[98:1], in[98]};
        out_different = in ^ {in[99], in[98:0]};
    end

endmodule
