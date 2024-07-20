module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casex (in)
        8'b000000001: pos = 3'd0;
        8'b00000001x: pos = 3'd1;
        8'b0000011xx: pos = 3'd2;
        8'b000111xxx: pos = 3'd3;
        8'b011xxxxxx: pos = 3'd4;
        8'b1xxxxxxxx: pos = 3'd5;
        default: pos = 3'd0;
    endcase
end

endmodule
