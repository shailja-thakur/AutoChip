module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0010, 4'b0011,  // 00 | 1 | 1
        4'b0110, 4'b0111,  // 10 | 1 | 1
        4'b1010, 4'b1011,  // 11 | 1 | 1
        4'b1110, 4'b1111,  // 11 | 1 | 1
        4'b1000: out = 1'b1; // 10 | 1
        default: out = 1'b0; // all other combinations
    endcase
end

endmodule
