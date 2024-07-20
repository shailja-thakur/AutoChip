module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'bxxxx: out = 1;
        4'bxx01: out = 0;
        4'bxx11: out = 1;
        4'bxx10: out = 1;
        default: out = 1; // Don't care case
    endcase
end

endmodule
