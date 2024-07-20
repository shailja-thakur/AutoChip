module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b11111111: pos = 3'd7;
        8'b1111111z: pos = 3'd6;
        8'b111111zz: pos = 3'd5;
        8'b11111zzz: pos = 3'd4;
        8'b1111zzzz: pos = 3'd3;
        8'b111zzzzz: pos = 3'd2;
        8'b11zzzzzz: pos = 3'd1;
        8'b1zzzzzzz: pos = 3'd0;
        default: pos = 3'd0;
    endcase
end

endmodule
