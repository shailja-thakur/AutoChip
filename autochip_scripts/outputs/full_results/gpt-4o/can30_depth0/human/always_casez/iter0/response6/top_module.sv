module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casex (in)
            8'b00000001: pos = 3'd0;
            8'b0000001x: pos = 3'd1;
            8'b000001xx: pos = 3'd2;
            8'b00001xxx: pos = 3'd3;
            8'b0001xxxx: pos = 3'd4;
            8'b001xxxxx: pos = 3'd5;
            8'b01xxxxxx: pos = 3'd6;
            8'b1xxxxxxx: pos = 3'd7;
            default: pos = 3'd0; // Report zero if no bits are high
        endcase
    end
endmodule
