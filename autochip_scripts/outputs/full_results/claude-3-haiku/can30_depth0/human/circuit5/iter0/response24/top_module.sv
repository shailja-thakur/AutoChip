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
        4'd0: q = b;
        4'd1: q = e;
        4'd2: q = a;
        4'd3: q = d;
        4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9, 4'hA, 4'hB, 4'hC, 4'hD, 4'hE, 4'hF: q = 4'hF;
        default: q = 4'bx;
    endcase
end

endmodule
