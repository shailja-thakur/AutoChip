module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b, c, d})
        4'b0000, 4'b0111, 4'b1011, 4'b1110: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
