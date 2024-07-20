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
        4'd4,
        4'd5,
        4'd6,
        4'd7,
        4'd8,
        4'd9,
        4'd10,
        4'd11,
        4'd12,
        4'd13,
        4'd14,
        4'd15: q = 4'hf;
        default: q = 4'hx;
    endcase
end

endmodule
