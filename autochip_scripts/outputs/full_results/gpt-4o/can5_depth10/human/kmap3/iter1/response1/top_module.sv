module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000: out = 1'b0; // 00 00 -> 0
        4'b0001: out = 1'b0; // 00 01 -> 0
        4'b0010: out = 1'b1; // 00 10 -> 1
        4'b0011: out = 1'b1; // 00 11 -> 1

        4'b0100: out = 1'b0; // 01 00 -> 0
        4'b0101: out = 1'b0; // 01 01 -> 0
        4'b0110: out = 1'b1; // 01 10 -> 1 (chosen for don't-care)
        4'b0111: out = 1'b1; // 01 11 -> 1 (chosen for don't-care)

        4'b1000: out = 1'b0; // 10 00 -> 0
        4'b1001: out = 1'b0; // 10 01 -> 0
        4'b1010: out = 1'b1; // 10 10 -> 1
        4'b1011: out = 1'b1; // 10 11 -> 1

        4'b1100: out = 1'b0; // 11 00 -> 0
        4'b1101: out = 1'b1; // 11 01 -> 1
        4'b1110: out = 1'b1; // 11 10 -> 1
        4'b1111: out = 1'b1; // 11 11 -> 1

        default: out = 1'b0; // Default to 0 for safety
    endcase
end

endmodule
