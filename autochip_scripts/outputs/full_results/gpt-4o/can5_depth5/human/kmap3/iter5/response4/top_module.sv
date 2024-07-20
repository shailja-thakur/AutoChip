module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001: out = 1'b0; // c=0, d=0, a=0, b=1
        4'b0010: out = 1'b1; // c=0, d=0, a=1, b=0
        4'b0011: out = 1'b1; // c=0, d=0, a=1, b=1
        4'b0100: out = 1'b0; // c=0, d=1, a=0, b=0
        4'b0101: out = 1'b0; // c=0, d=1, a=0, b=1
        4'b0110: out = 1'b0; // d=0 -> don't care (choosing convenient value 0)
        4'b0111: out = 1'b0; // d=0 -> don't care (choosing convenient value 0)
        4'b1000: out = 1'b0; // c=1, d=0, a=0, b=0
        4'b1001: out = 1'b1; // c=1, d=0, a=0, b=1
        4'b1010: out = 1'b1; // c=1, d=0, a=1, b=0
        4'b1011: out = 1'b1; // c=1, d=0, a=1, b=1
        4'b1100: out = 1'b1; // d=1 -> don't care (choosing convenient value 1)
        4'b1101: out = 1'b1; // c=1, d=1, a=0, b=1
        4'b1110: out = 1'b1; // c=1, d=1, a=1, b=0
        4'b1111: out = 1'b1; // c=1, d=1, a=1, b=1
        default: out = 1'b0;
    endcase
end

endmodule
