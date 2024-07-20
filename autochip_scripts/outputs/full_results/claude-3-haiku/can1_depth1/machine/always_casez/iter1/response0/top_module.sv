module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b11111111: pos = 3'b111;
        8'b1111111z: pos = 3'b110;
        8'b111111zz: pos = 3'b101;
        8'b11111zzz: pos = 3'b100;
        8'b1111zzzz: pos = 3'b011;
        8'b111zzzzz: pos = 3'b010;
        8'b11zzzzzz: pos = 3'b001;
        8'b1zzzzzzz: pos = 3'b000;
        default: pos = 3'b000;
    endcase
end

endmodule
