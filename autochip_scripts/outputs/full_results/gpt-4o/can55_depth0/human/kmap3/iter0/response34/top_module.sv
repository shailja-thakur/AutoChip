module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000: out = 0;     // cd = 00, ab = 00 -> 0
        4'b0001: out = 0;     // cd = 00, ab = 01 -> d (0 chosen)
        4'b0010: out = 1;     // cd = 00, ab = 10 -> 1
        4'b0011: out = 1;     // cd = 00, ab = 11 -> 1
        4'b0100: out = 0;     // cd = 01, ab = 00 -> 0
        4'b0101: out = 0;     // cd = 01, ab = 01 -> 0
        4'b0110: out = 1;     // cd = 01, ab = 10 -> d (1 chosen)
        4'b0111: out = 1;     // cd = 01, ab = 11 -> d (1 chosen)
        4'b1000: out = 0;     // cd = 10, ab = 00 -> 0
        4'b1001: out = 1;     // cd = 10, ab = 01 -> 1
        4'b1010: out = 1;     // cd = 10, ab = 10 -> 1
        4'b1011: out = 1;     // cd = 10, ab = 11 -> 1
        4'b1100: out = 0;     // cd = 11, ab = 00 -> 0
        4'b1101: out = 1;     // cd = 11, ab = 01 -> 1
        4'b1110: out = 1;     // cd = 11, ab = 10 -> 1
        4'b1111: out = 1;     // cd = 11, ab = 11 -> 1
        default: out = 0;     // Default case (shouldn't happen)
    endcase
end

endmodule
