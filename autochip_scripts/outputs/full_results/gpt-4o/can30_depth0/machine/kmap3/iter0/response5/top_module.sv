module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    reg [3:0] abcd;

    always @(*) begin
        abcd = {a, b, c, d};
        case (abcd)
            4'b0000: out = 0;    // 0
            4'b0001: out = 0;    // 1
            4'b0010: out = 1;    // 2
            4'b0011: out = 1;    // 3
            4'b0100: out = 1'bx; // 4
            4'b0101: out = 0;    // 5
            4'b0110: out = 0;    // 6
            4'b0111: out = 0;    // 7
            4'b1000: out = 1;    // 8
            4'b1001: out = 1'bx; // 9
            4'b1010: out = 1;    // a (10)
            4'b1011: out = 1;    // b (11)
            4'b1100: out = 1;    // c (12)
            4'b1101: out = 1'bx; // d (13)
            4'b1110: out = 1;    // e (14)
            4'b1111: out = 1;    // f (15)
            default: out = 1'bx;
        endcase
    end
endmodule
