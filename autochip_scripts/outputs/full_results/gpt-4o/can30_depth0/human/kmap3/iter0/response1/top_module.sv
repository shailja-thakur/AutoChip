module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
    always @(*) begin
        case ({c, d, a, b})
            4'b0000: out = 1'b0;  // cd00, ab00
            4'b0001: out = 1'b1;  // cd00, ab01
            4'b0010: out = 1'b1;  // cd00, ab10
            4'b0011: out = 1'b1;  // cd00, ab11
            4'b0100: out = 1'b0;  // cd01, ab00
            4'b0101: out = 1'b0;  // cd01, ab01
            4'b1000: out = 1'b0;  // cd10, ab00
            4'b1001: out = 1'b1;  // cd10, ab01
            4'b1010: out = 1'b1;  // cd10, ab10
            4'b1011: out = 1'b1;  // cd10, ab11
            4'b1100: out = 1'b1;  // cd11, ab00
            4'b1101: out = 1'b1;  // cd11, ab01
            4'b1110: out = 1'b1;  // cd11, ab10
            4'b1111: out = 1'b1;  // cd11, ab11
            default: out = 1'b0;  // Consider don't-care as 0
        endcase
    end
endmodule
