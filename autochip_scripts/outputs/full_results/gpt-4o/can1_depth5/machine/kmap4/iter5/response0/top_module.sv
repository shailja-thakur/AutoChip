module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            // Only a subset of the 4-bit combinations are remapped for illustration purposes.
            4'b0000: out = 0;  // 0 + 0 + 0 + 0 = 0 (even)
            4'b0001: out = 1;  // 0 + 0 + 0 + 1 = 1 (odd)
            4'b0010: out = 1;  // 0 + 0 + 1 + 0 = 1 (odd)
            4'b0011: out = 0;  // 0 + 0 + 1 + 1 = 2 (even)
            4'b0100: out = 1;  // 0 + 1 + 0 + 0 = 1 (odd)
            4'b0101: out = 0;  // 0 + 1 + 0 + 1 = 2 (even)
            4'b0110: out = 0;  // 0 + 1 + 1 + 0 = 2 (even)
            4'b0111: out = 1;  // 0 + 1 + 1 + 1 = 3 (odd)
            4'b1000: out = 1;  // 1 + 0 + 0 + 0 = 1 (odd)
            4'b1001: out = 0;  // 1 + 0 + 0 + 1 = 2 (even)
            4'b1010: out = 0;  // 1 + 0 + 1 + 0 = 2 (even)
            4'b1011: out = 1;  // 1 + 0 + 1 + 1 = 3 (odd)
            4'b1100: out = 0;  // 1 + 1 + 0 + 0 = 2 (even)
            4'b1101: out = 1;  // 1 + 1 + 0 + 1 = 3 (odd)
            4'b1110: out = 1;  // 1 + 1 + 1 + 0 = 3 (odd)
            4'b1111: out = 0;  // 1 + 1 + 1 + 1 = 4 (even)
            default: out = 0;
        endcase
    end
endmodule
