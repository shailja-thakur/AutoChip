module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case (c)
        4'b0000: q = b;  // c == 0
        4'b0001: q = e;  // c == 1
        4'b0010: q = a;  // c == 2
        4'b0011: q = d;  // c == 3
        4'b0100: q = 4'b1111;  // c == 4
        4'b0101: q = 4'b1111;  // c == 5
        4'b0110: q = 4'b1111;  // c == 6
        4'b0111: q = 4'b1111;  // c == 7
        4'b1000: q = 4'b1111;  // c == 8
        4'b1001: q = 4'b1111;  // c == 9
        4'b1010: q = 4'b1111;  // c == 10 (decimal)
        4'b1011: q = 4'b1111;  // c == 11 (decimal)
        4'b1100: q = 4'b1111;  // c == 12 (decimal)
        4'b1101: q = 4'b1111;  // c == 13 (decimal)
        4'b1110: q = 4'b1111;  // c == 14 (decimal)
        4'b1111: q = 4'b1111;  // c == 15 (decimal)
        default: q = 4'b0000;  // Default case (should never happen with a 4-bit input)
    endcase
end

endmodule
