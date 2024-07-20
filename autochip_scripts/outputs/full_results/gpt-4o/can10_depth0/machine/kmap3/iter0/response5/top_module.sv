module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: out = 1'b0; // 0
            4'b0001: out = 1'b0; // 1
            4'b0010: out = 1'b1; // 2
            4'b0011: out = 1'b1; // 3
            4'b0100: out = 1'bx; // 4
            4'b0101: out = 1'b0; // 5
            4'b0110: out = 1'b0; // 6
            4'b0111: out = 1'b0; // 7
            4'b1000: out = 1'b1; // 8
            4'b1001: out = 1'bx; // 9
            4'b1010: out = 1'b1; // A
            4'b1011: out = 1'b1; // B
            4'b1100: out = 1'b1; // C
            4'b1101: out = 1'bx; // D
            4'b1110: out = 1'b1; // E
            4'b1111: out = 1'b1; // F
            default: out = 1'b0;
        endcase
    end

endmodule
