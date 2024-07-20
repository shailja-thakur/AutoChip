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
        4'b{c, c, c, c}: out = 1'b1;
        4'b{d, d, d, d}: out = 1'bx;
        4'b1111: out = 1'b1;
        4'b1110: out = 1'b1;
        4'b1000: out = 1'b1;
        4'b1001: out = 1'bx;
        4'b{b, b, b, b}: out = 1'b1;
        4'b{a, a, a, a}: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
