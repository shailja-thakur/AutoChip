module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000, 4'b0001: out = 0;   // 00 00 and 01
        4'b0010, 4'b0011: out = 1;   // 00 10 and 11
        4'b0100, 4'b0101, 4'b0110, 4'b0111: out = 0; // 01 00 to 01 11 (default don't care is '0')
        4'b1000, 4'b1001, 4'b1010, 4'b1011: out = 1; // 11 00 to 11 11
        4'b1100, 4'b1101, 4'b1110, 4'b1111: out = 1; // 10 00 to 10 11
        default: out = 0;  // default case to handle any undefined states (safe option)
    endcase
end

endmodule
