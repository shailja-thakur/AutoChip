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
        4'd4: q = 4'hf;
        4'd5: q = 4'hf;
        4'd6: q = 4'hf;
        4'd7: q = 4'hf;
        4'd8: q = 4'hf;
        4'd9: q = 4'hf;
        4'd10: q = 4'hf;
        4'd11: q = 4'hf;
        4'd12: q = 4'hf;
        4'd13: q = 4'hf;
        default: q = 4'hf;
    endcase
end

endmodule
