module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})  // Combination of c, d, a, and b as a single 4-bit value
        4'b0000: out = 0;
        4'b0001: out = 0;
        4'b0010: out = 1;
        4'b0011: out = 1;
        4'b0100: out = 0;
        4'b0101: out = 0;
        // Don't-care cases can be assigned arbitrarily
        4'b0110: out = 1;  // d, so assigned 1 conveniently
        4'b0111: out = 1;  // d, so assigned 1 conveniently
        4'b1000: out = 0;  
        4'b1001: out = 1;
        4'b1010: out = 1;
        4'b1011: out = 1;
        4'b1100: out = 0;
        4'b1101: out = 1;
        4'b1110: out = 1;
        4'b1111: out = 1;
        default: out = 0;   // Default case, typically safe to set to 0
    endcase
end

endmodule
