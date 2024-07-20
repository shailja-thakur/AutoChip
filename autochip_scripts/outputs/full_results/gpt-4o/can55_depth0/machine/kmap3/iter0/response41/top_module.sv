module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: out = 1'b0;
            4'b0001: out = 1'b0;
            4'b0011: out = 1'b1;
            4'b0010: out = 1'b1;
            4'b0100: out = 1'bx;
            4'b0101: out = 1'b0;
            4'b0111: out = 1'b0;
            4'b0110: out = 1'b0;
            4'b1100: out = 1'b1; // 'c' in hexadecimal is 12, which is 4'b1100
            4'b1101: out = 1'bx; // 'd' in hexadecimal is 13, which is 4'b1101
            4'b1111: out = 1'b1; // 'f' in hexadecimal is 15, which is 4'b1111
            4'b1110: out = 1'b1; // 'e' in hexadecimal is 14, which is 4'b1110
            4'b1000: out = 1'b1;
            4'b1001: out = 1'bx;
            4'b1011: out = 1'b1; // 'b' in hexadecimal is 11, which is 4'b1011
            4'b1010: out = 1'b1; // 'a' in hexadecimal is 10, which is 4'b1010
            default: out = 1'b0;
        endcase
    end
    
endmodule
