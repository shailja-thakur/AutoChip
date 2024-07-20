module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case (c)
        0: q = b;
        1: q = e;
        2: q = a;
        3: q = d;
        4: q = 4'hf;
        5: q = 4'hf;
        6: q = 4'hf;
        7: q = 4'hf;
        8: q = 4'hf;
        9: q = 4'hf;
        4'ha: q = 4'hf;
        4'hb: q = 4'hf;
        4'hc: q = 4'hf;
        4'hd: q = 4'hf;
        4'he: q = 4'hf;
        4'hf: q = 4'hf;
        default: q = 4'bx;
    endcase
end

endmodule
