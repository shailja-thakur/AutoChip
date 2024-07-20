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
        16'h0: q = 4'hb;
        16'h1: q = 4'he;
        16'h2: q = 4'ha;
        16'h3: q = 4'hd;
        16'h4: q = 4'hf;
        16'h5: q = 4'hf;
        16'h6: q = 4'hf;
        16'h7: q = 4'hf;
        16'h8: q = 4'hf;
        16'h9: q = 4'hf;
        16'ha: q = 4'hf;
        16'hb: q = 4'hf;
        16'hc: q = 4'hf;
        16'hd: q = 4'hf;
        16'he: q = 4'hf;
        16'hf: q = 4'hf;
        default: q = 4'hf;
    endcase
end

endmodule
