module top_module(
    input [3:0] y, // 4-bit input
    input w, // 1-bit input
    output reg Y2 // 1-bit output
);

always_comb begin // Always combination block, no clock
    case ({y, w}) // Case statement with combined inputs
        5'b00000: Y2 = 0; // y = 4'h0, w = 0
        5'b00001: Y2 = 0; // y = 4'h0, w = 1
        5'b00010: Y2 = 1; // y = 4'h1, w = 0
        5'b00011: Y2 = 1; // y = 4'h1, w = 1
        5'b00100: Y2 = 0; // y = 4'h2, w = 0
        5'b00101: Y2 = 1; // y = 4'h2, w = 1
        5'b00110: Y2 = 0; // y = 4'h3, w = 0
        5'b00111: Y2 = 0; // y = 4'h3, w = 1
        5'b01000: Y2 = 0; // y = 4'h4, w = 0
        5'b01001: Y2 = 1; // y = 4'h4, w = 1
        5'b01010: Y2 = 1; // y = 4'h5, w = 0
        5'b01011: Y2 = 1; // y = 4'h5, w = 1
        5'b01100: Y2 = 0; // y = 4'h6, w = 0
        5'b01101: Y2 = 0; // y = 4'h6, w = 1
        5'b01110: Y2 = 0; // y = 4'h7, w = 0
        5'b01111: Y2 = 0; // y = 4'h7, w = 1
        5'b10000: Y2 = 0; // y = 4'h8, w = 0
        5'b10001: Y2 = 0; // y = 4'h8, w = 1
        5'b10010: Y2 = 1; // y = 4'h9, w = 0
        5'b10011: Y2 = 1; // y = 4'h9, w = 1
        5'b10100: Y2 = 1; // y = 4'hA, w = 0
        5'b10101: Y2 = 1; // y = 4'hA, w = 1
        5'b10110: Y2 = 1; // y = 4'hB, w = 0
        5'b10111: Y2 = 1; // y = 4'hB, w = 1
        default: Y2 = 0; // Any other input combination
    endcase
end

endmodule
