module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: out = 0;      // 0 in hex
            4'b0001: out = 0;      // 1 in hex
            4'b0011: out = 1;      // 3 in hex
            4'b0010: out = 1;      // 2 in hex
            4'b0100: out = 1'bx;   // 4 in hex
            4'b0101: out = 0;      // 5 in hex
            4'b0111: out = 0;      // 7 in hex
            4'b0110: out = 0;      // 6 in hex
            4'b1100: out = 1;      // C (12 in decimal)
            4'b1101: out = 1'bx;   // D (13 in decimal)
            4'b1111: out = 1;      // F (15 in decimal)
            4'b1110: out = 1;      // E (14 in decimal)
            4'b1000: out = 1;      // 8 in hex
            4'b1001: out = 1'bx;   // 9 in hex
            4'b1011: out = 1;      // B (11 in decimal)
            4'b1010: out = 1;      // A (10 in decimal)
            default: out = 1'bx;
        endcase
    end

endmodule
