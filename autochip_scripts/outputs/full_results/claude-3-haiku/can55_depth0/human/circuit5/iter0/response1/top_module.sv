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
        4'h0: q = b;
        4'h1: q = e;
        4'h2: q = a;
        4'h3: q = d;
        4'h4: q = 4'hf;
        4'h5: q = 4'hf;
        4'h6: q = 4'hf;
        4'h7: q = 4'hf;
        4'h8: q = 4'hf;
        4'h9: q = 4'hf;
        4'ha: q = 4'hf;
        4'hb: q = 4'hf;
        4'hc: q = 4'hf;
        4'hd: q = 4'hf;
        4'he: q = 4'hf;
        4'hf: q = 4'hf;
    endcase
end

endmodule
