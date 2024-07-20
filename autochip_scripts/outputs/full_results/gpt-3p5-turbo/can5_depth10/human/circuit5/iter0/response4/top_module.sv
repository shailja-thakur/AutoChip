module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case ({a, b, c, d, e})
        5'bxxxxx: q = 4'bxxxx;
        5'b01100: q = b;
        5'b01101: q = e;
        5'b01110: q = a;
        5'b01111: q = d;
        5'b10000: q = f;
        default: q = f;
    endcase
end

endmodule
