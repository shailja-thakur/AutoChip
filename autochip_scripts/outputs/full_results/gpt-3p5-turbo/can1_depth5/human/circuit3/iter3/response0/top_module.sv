module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

always @(*) begin
    case ({a, b, c, d})
        4'b0000: q = 0;
        4'b0010: q = 0;
        4'b0101: q = 0;
        default: q = 1;
    endcase
end

endmodule
