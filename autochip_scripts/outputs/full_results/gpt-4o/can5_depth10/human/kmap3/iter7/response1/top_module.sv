module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b}) // Reviewing the Karnaugh map and modifying the order to fit the map
        4'b0001: out = 1'b0; // ab=01, cd=00
        4'b0010: out = 1'b0; // ab=00, cd=01
        4'b0100: out = 1'b1; // ab=10, cd=00
        4'b0101: out = 1'b1; // ab=11, cd=00
        4'b0111: out = 1'b0; // ab=00, cd=11
        4'b1001: out = 1'b0; // ab=01, cd=01
        4'b1010: out = 1'b1; // ab=10, cd=10
        4'b1011: out = 1'b1; // ab=11, cd=10
        4'b1100: out = 1'b0; // ab=00, cd=10
        4'b1101: out = 1'b1; // ab=01, cd=10
        4'b1110: out = 1'b1; // ab=10, cd=11
        4'b1111: out = 1'b1; // ab=11, cd=11
        default: out = 1'b0; // Default to 0 for safety
    endcase
end

endmodule
