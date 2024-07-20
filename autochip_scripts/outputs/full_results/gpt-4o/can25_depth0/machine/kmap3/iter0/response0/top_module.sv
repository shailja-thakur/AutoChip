module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(a or b or c or d) begin
    case ({a, b, c, d})
        4'b0000: out = 1'b0;
        4'b0001: out = 1'b0;
        4'b0011: out = 1'b1;
        4'b0010: out = 1'b1;
        4'b0100: out = 1'bx;
        4'b0101: out = 1'b0;
        4'b0111: out = 1'b0;
        4'b0110: out = 1'b0;
        4'b1100: out = 1'b1;  // c (12 in decimal) represented as 1100 in binary
        4'b1101: out = 1'bx;  // d (13 in decimal) represented as 1101 in binary
        4'b1111: out = 1'b1;  // f (15 in decimal) represented as 1111 in binary
        4'b1110: out = 1'b1;  // e (14 in decimal) represented as 1110 in binary
        4'b1000: out = 1'b1;  // 8 (8 in decimal) represented as 1000 in binary
        4'b1001: out = 1'bx;  // 9 (9 in decimal) represented as 1001 in binary
        4'b1011: out = 1'b1;  // b (11 in decimal) represented as 1011 in binary
        4'b1010: out = 1'b1;  // a (10 in decimal) represented as 1010 in binary
        default: out = 1'b0;
    endcase
end

endmodule
