module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({c, d})
            2'b00: out = b;           // 00 row: b
            2'b01: out = a ^ b;       // 01 row: a xor b
            2'b10: out = a == b;      // 10 row: a == b
            2'b11: out = a ^ ~b;      // 11 row: a xor not b (a ^ ~b)
            default: out = 1'b0;
        endcase
    end

endmodule
