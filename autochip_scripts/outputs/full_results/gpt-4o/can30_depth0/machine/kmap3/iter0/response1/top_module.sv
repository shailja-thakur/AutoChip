module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: out = 0;
            4'b0001: out = 0;
            4'b0010: out = 1;
            4'b0011: out = 1;
            4'b0100: out = 1'bx;
            4'b0101: out = 0;
            4'b0111: out = 0;
            4'b0110: out = 0;
            4'b1010: out = 1; // a,b,c,d == 1010 (a)
            4'b1011: out = 1; // a,b,c,d == 1011 (b)
            4'b1100: out = 1; // a,b,c,d == 1100 (c)
            4'b1101: out = 1'bx; // a,b,c,d == 1101 (d)
            4'b1110: out = 1; // a,b,c,d == 1110 (e)
            4'b1111: out = 1; // a,b,c,d == 1111 (f)
            4'b1000: out = 1; // a,b,c,d == 1000 (8)
            4'b1001: out = 1'bx; // a,b,c,d == 1001 (9)
            default: out = 1'bx; // undefined cases
        endcase
    end

endmodule
