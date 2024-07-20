module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'h0: out = 1;
        4'h1: out = d;
        4'h2: out = b;
        4'h3: out = 1;
        4'h4: out = 0;
        4'h5: out = 0;
        4'h6: out = d;
        4'h7: out = d;
        4'h8: out = a;
        4'h9: out = 1;
        4'ha: out = 1;
        4'hb: out = 1;
        4'hc: out = 0;
        4'hd: out = 1;
        4'he: out = 1;
        4'hf: out = 1;
    endcase
end

endmodule
