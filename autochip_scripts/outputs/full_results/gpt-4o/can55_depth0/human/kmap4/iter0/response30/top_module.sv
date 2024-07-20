module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        2'b00: out = ~a & b;     // 0 | 1 | 0 | 1
        2'b01: out = a & ~b;     // 1 | 0 | 1 | 0
        2'b11: out = ~a & b;     // 0 | 1 | 0 | 1
        2'b10: out = a & ~b;     // 1 | 0 | 1 | 0
        default: out = 0;
    endcase
end

endmodule
