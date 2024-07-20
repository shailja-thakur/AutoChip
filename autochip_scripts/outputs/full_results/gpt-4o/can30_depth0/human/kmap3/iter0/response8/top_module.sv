module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001: out = 1'b0;    // 00 | 01
        4'b0010: out = 1'b1;    // 00 | 10
        4'b0011: out = 1'b1;    // 00 | 11
        4'b0100: out = 1'b0;    // 01 | 00
        4'b0110: out = 1'bx;    // 01 | 10 (don't-care)
        4'b0111: out = 1'bx;    // 01 | 11 (don't-care)
        4'b1100: out = 1'b1;    // 11 | 00
        4'b1101: out = 1'b1;    // 11 | 01
        4'b1110: out = 1'b1;    // 11 | 10
        4'b1111: out = 1'b1;    // 11 | 11
        4'b1000: out = 1'b0;    // 10 | 00
        4'b1001: out = 1'b1;    // 10 | 01
        4'b1010: out = 1'b1;    // 10 | 10
        4'b1011: out = 1'b1;    // 10 | 11
        default: out = 1'b0;    // Don't-care states can be considered as zeros
    endcase
end

endmodule
