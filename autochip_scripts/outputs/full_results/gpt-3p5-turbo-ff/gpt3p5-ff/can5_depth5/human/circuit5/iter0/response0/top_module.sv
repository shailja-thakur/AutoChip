module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @* begin
    case ({a, b, c, d, e})
        // Simulation Waveforms:
        // a   b   c   d   e   q
        // 0   0   0   0   0   0
        // 1   0   0   1   1   1
        // 2   0   1   0   1   2
        // 3   0   1   1   1   3
        // 4   1   0   0   1   4
        // 5   1   0   1   1   5
        // 6   1   1   0   1   6
        // 7   1   1   1   1   7
        // 8   0   0   0   0   8
        // 9   0   0   1   0   9
        // A   0   1   0   0   A
        // B   0   1   1   0   B
        // C   1   0   0   0   C
        // D   1   0   1   0   D
        // E   1   1   0   0   E
        // F   1   1   1   0   F
        4'b0000: q = 4'b0000;
        4'b0001: q = 4'b0001;
        4'b0010: q = 4'b0010;
        4'b0011: q = 4'b0011;
        4'b0100: q = 4'b0100;
        4'b0101: q = 4'b0101;
        4'b0110: q = 4'b0110;
        4'b0111: q = 4'b0111;
        4'b1000: q = 4'b1000;
        4'b1001: q = 4'b1001;
        4'b1010: q = 4'b1010;
        4'b1011: q = 4'b1011;
        4'b1100: q = 4'b1100;
        4'b1101: q = 4'b1101;
        4'b1110: q = 4'b1110;
        4'b1111: q = 4'b1111;
    endcase
end

endmodule
