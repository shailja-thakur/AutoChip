module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        2'b00: out = b;        // c == 0, d == 0
        2'b01: out = a;        // c == 0, d == 1
        2'b11: out = b;        // c == 1, d == 1
        2'b10: out = a;        // c == 1, d == 0
    endcase
end

endmodule
