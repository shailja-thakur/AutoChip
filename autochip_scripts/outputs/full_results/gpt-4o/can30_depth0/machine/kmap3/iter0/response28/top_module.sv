module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({a, b, c, d})
            4'b0000: out = 0;
            4'b0001: out = 0;
            4'b0011: out = 1;
            4'b0010: out = 1;
            4'b0100: out = 1'bx;
            4'b0101: out = 0;
            4'b0111: out = 0;
            4'b0110: out = 0;
            4'hC: out = 1;   // 4'b1100
            4'hD: out = 1'bx; // 4'b1101
            4'hF: out = 1;   // 4'b1111
            4'hE: out = 1;   // 4'b1110
            4'b1000: out = 1;
            4'b1001: out = 1'bx;
            4'hB: out = 1;   // 4'b1011
            4'hA: out = 1;   // 4'b1010
            default: out = 1'bx;
        endcase
    end

endmodule
