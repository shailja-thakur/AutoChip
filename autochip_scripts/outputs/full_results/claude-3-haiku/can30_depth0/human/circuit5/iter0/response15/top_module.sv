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
        4'h0:
            q = b;
        4'h1:
            q = e;
        4'h2:
            q = a;
        4'h3:
            q = d;
        4'h4, 4'h5, 4'h6, 4'h7, 4'h8, 4'h9, 4'hA, 4'hB, 4'hC, 4'hD, 4'hE, 4'hF:
            q = 4'hF;
    endcase
end

endmodule
