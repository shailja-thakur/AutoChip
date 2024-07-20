module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        case ({c, d, a, b})
            4'b00x0: out = 1; // d = 0, a = don't care
            4'b01xx: out = 0; // a = 0, b = don't care
            4'b11xx: out = 1; // a = 1, b = don't care
            4'b10xx: out = 1; // a = 1, b = don't care
            default: out = 1; // default case
        endcase
    end

endmodule
