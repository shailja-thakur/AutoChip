module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000, 4'b0001,                    // d, 0
        4'b0100, 4'b0101,                    // 0, 0
        4'b1100, 4'b1110, 4'b1111,           // 0, 1, 1
        4'b1000, 4'b1001: out = 0;           // 0, 1
        4'b0010, 4'b0011,                    // 1, 1
        4'b1010, 4'b1011: out = 1;           // 1, 1
        default: out = 0;                    // Default to 0 for simplicity
    endcase
end

endmodule
