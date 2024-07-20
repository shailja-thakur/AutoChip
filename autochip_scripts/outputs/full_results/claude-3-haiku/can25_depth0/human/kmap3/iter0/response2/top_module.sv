module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000, 4'b1100, 4'b1010, 4'b1011: out = 1'b1;
        4'b0100, 4'b0101: out = 1'b0;
        default: out = 1'bx; // Don't-care condition
    endcase
end

endmodule
