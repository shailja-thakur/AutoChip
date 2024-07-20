module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casex (in)
        8'b0000_0001: pos = 3'd0;
        8'b0000_001x: pos = 3'd1;
        8'b0000_01xx: pos = 3'd2;
        8'b0000_1xxx: pos = 3'd3;
        8'b0001_xxxx: pos = 3'd4;
        8'b001x_xxxx: pos = 3'd5;
        8'b01xx_xxxx: pos = 3'd6;
        8'b1xxx_xxxx: pos = 3'd7;
        default: pos = 3'd0;
    endcase
end

endmodule
