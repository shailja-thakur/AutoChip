module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @* begin
    case ({c, d, a, b})
        4'b00x0: out = 1;
        4'b01x1: out = d;
        4'b11x1: out = 0;
        4'b10x1: out = 1;
        default: out = 0;
    endcase
end

endmodule
