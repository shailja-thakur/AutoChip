module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001: out = 1'b1;
        4'b0000: out = 1'b0;
        4'b1011: out = 1'b1;
        4'b1010: out = 1'b1;
        4'b0111: out = 1'b1;
        4'b0110: out = 1'b1;
        default: out = 1'b1; // Handling the don't-care condition
    endcase
end

endmodule
