module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    case (in)
        8'b10000000: pos = 3'd7;
        8'b01000000: pos = 3'd6;
        8'b00100000: pos = 3'd5;
        8'b00010000: pos = 3'd4;
        8'b00001000: pos = 3'd3;
        8'b00000100: pos = 3'd2;
        8'b00000010: pos = 3'd1;
        8'b00000001: pos = 3'd0;
        default:     pos = 3'd0;
    endcase
end

endmodule
