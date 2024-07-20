module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
    always @(*) begin
        case ({a, b, c, d})
            4'h0: out = 1'b0; // 0
            4'h1: out = 1'b0; // 1
            4'h2: out = 1'b1; // 2
            4'h3: out = 1'b1; // 3
            4'h4: out = 1'bx; // 4
            4'h5: out = 1'b0; // 5
            4'h6: out = 1'b0; // 6
            4'h7: out = 1'b0; // 7
            4'h8: out = 1'b1; // 8
            4'h9: out = 1'bx; // 9
            4'hA: out = 1'b1; // 10 (A)
            4'hB: out = 1'b1; // 11 (B)
            4'hC: out = 1'b1; // 12 (C)
            4'hD: out = 1'bx; // 13 (D)
            4'hE: out = 1'b1; // 14 (E)
            4'hF: out = 1'b1; // 15 (F)
            default: out = 1'bx; // catch-all for undefined states
        endcase
    end
endmodule
