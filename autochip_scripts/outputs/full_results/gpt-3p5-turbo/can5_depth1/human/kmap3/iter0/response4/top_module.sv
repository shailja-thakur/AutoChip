module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);
    always @* begin
        case ({c, d, a, b})
            4'b00_0: out = 1;
            4'b00_1: out = 0;
            4'b01_0: out = 0;
            4'b01_1: out = d;
            4'b11_0: out = 0;
            4'b11_1: out = 1;
            4'b10_0: out = 0;
            4'b10_1: out = 1;
            default: out = 1;
        endcase
    end
endmodule
