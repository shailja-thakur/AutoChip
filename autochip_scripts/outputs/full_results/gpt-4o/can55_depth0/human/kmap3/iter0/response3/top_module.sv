module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001, 4'b0011, 4'b0110, 4'b0111,
        4'b1110, 4'b1111, 4'b1010, 4'b1011: out = 1;
        4'b0000, 4'b0100, 4'b0101, 4'b1100, 4'b1000: out = 0;
        default: out = 0; // Handling don't-care conditions as convenient
    endcase
end

endmodule
