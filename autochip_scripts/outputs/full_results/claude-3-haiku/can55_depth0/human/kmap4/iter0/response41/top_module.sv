module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000, 4'b0111, 4'b1011, 4'b1110: out = 1'b1;
        4'b0001, 4'b0010, 4'b0101, 4'b1001, 4'b1100, 4'b1101: out = 1'b0;
        default: out = 1'bx;
    endcase
end

endmodule
