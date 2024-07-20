module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001, 4'b0010, 4'b0011, // d0001, d0010, d0011
        4'b0120, 4'b0121, 4'b0110, 4'b0111, // d1000, d1001, d1010, d1011
        4'b1000, 4'b1001, 4'b1010, 4'b1011, // d1100, d1101, d1110, d1111
        4'b1100, 4'b1101, 4'b1110, 4'b1111:    // Correct Pin order
            out = 1'b0;
        default:
            out = 1'b0;
    endcase
end

endmodule
