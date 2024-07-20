module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b, c, d})
        4'b0000: out = 0;    // a,b,c,d == 0
        4'b0001: out = 0;    // a,b,c,d == 1
        4'b0011: out = 1;    // a,b,c,d == 3
        4'b0010: out = 1;    // a,b,c,d == 2
        4'b0100: out = 1'bx; // a,b,c,d == 4
        4'b0101: out = 0;    // a,b,c,d == 5
        4'b0111: out = 0;    // a,b,c,d == 7
        4'b0110: out = 0;    // a,b,c,d == 6
        4'b1100: out = 1;    // a,b,c,d == c
        4'b1101: out = 1'bx; // a,b,c,d == d
        4'b1111: out = 1;    // a,b,c,d == f
        4'b1110: out = 1;    // a,b,c,d == e
        4'b1000: out = 1;    // a,b,c,d == 8
        4'b1001: out = 1'bx; // a,b,c,d == 9
        4'b1011: out = 1;    // a,b,c,d == b
        4'b1010: out = 1;    // a,b,c,d == a
        default: out = 1'bx; // handle other cases
    endcase
end

endmodule
