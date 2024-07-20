module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
    always @(*) begin
        case ({a,b,c,d})
            4'b0000: out = 0;
            4'b0001: out = 0;
            4'b0011: out = 1;
            4'b0010: out = 1;
            4'b0100: out = 1'bx;
            4'b0101: out = 0;
            4'b0111: out = 0;
            4'b0110: out = 0;
            4'b1100: out = 1; // 'c' in hex is 1100 in binary
            4'b1101: out = 1'bx; // 'd' in hex is 1101 in binary
            4'b1111: out = 1; // 'f' in hex is 1111 in binary
            4'b1110: out = 1; // 'e' in hex is 1110 in binary
            4'b1000: out = 1;
            4'b1001: out = 1'bx;
            4'b1011: out = 1; // 'b' in hex is 1011 in binary
            4'b1010: out = 1; // 'a' in hex is 1010 in binary
            default: out = 1'bx;
        endcase
    end
endmodule
