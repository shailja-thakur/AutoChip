module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        // CD = 00
        4'b0001: out = 1'b0; // AB=01
        4'b0000: out = 1'b0; // AB=00
        4'b0010: out = 1'b1; // AB=10
        4'b0011: out = 1'b1; // AB=11
        // CD = 01
        4'b0100: out = 1'b0; // AB=00
        4'b0101: out = 1'b0; // AB=01
        4'b0110: out = 1'b0; // AB=10 (don't-care, choose 0)
        4'b0111: out = 1'b0; // AB=11 (don't-care, choose 0)
        // CD = 10
        4'b1000: out = 1'b0; // AB=00 
        4'b1001: out = 1'b1; // AB=01
        4'b1010: out = 1'b1; // AB=10
        4'b1011: out = 1'b1; // AB=11
        // CD = 11
        4'b1100: out = 1'b0; // AB=00
        4'b1101: out = 1'b1; // AB=01
        4'b1110: out = 1'b1; // AB=10
        4'b1111: out = 1'b1; // AB=11
        default: out = 1'b0; // Just in case any undetermined states, though they should not occur
    endcase
end

endmodule
