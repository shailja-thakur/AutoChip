module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

    always @*
    begin
        case ({c, d, a, b})
            4'b00xx: out = 1;
            4'b010x: out = 1;
            4'b100x: out = 1;
            4'b110x: out = 1;
            4'b01x0: out = 1;
            4'b01x1: out = 1;
            4'b1100: out = 1;
            4'b111x: out = 1;
            default: out = 0;
        endcase
    end

endmodule
