module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, b, a})
        4'b0000: out = 'b0; // c=0, d=0, b=0, a=0
        4'b0001: out = 'b1; // c=0, d=0, b=0, a=1
        4'b0010: out = 'b0; // c=0, d=0, b=1, a=0
        4'b0011: out = 'b1; // c=0, d=0, b=1, a=1
        4'b0100: out = 'b0; // c=0, d=1, b=0, a=0
        4'b0101: out = 'b0; // c=0, d=1, b=0, a=1
        4'b0110: out = 'b0; // c=0, d=1, b=1, a=0
        4'b0111: out = 'b0; // c=0, d=1, b=1, a=1
        4'b1000: out = 'b1; // c=1, d=0, b=0, a=0
        4'b1001: out = 'b1; // c=1, d=0, b=0, a=1
        4'b1010: out = 'b1; // c=1, d=0, b=1, a=0
        4'b1011: out = 'b1; // c=1, d=0, b=1, a=1
        4'b1100: out = 'b1; // c=1, d=1, b=0, a=0
        4'b1101: out = 'b1; // c=1, d=1, b=0, a=1
        4'b1110: out = 'b1; // c=1, d=1, b=1, a=0
        4'b1111: out = 'b1; // c=1, d=1, b=1, a=1
        default: out = 'b0; // default case
    endcase
end

endmodule
