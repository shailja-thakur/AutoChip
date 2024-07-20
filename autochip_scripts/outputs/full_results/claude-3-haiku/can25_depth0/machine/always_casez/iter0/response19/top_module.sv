module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b11111111: pos = 3'b111; // 255
        8'b1zzzzzzz: pos = 3'b110; // 128 - 255
        8'bz1zzzzz: pos = 3'b101; // 64 - 127
        8'bzz1zzzz: pos = 3'b100; // 32 - 63
        8'bzzz1zzz: pos = 3'b011; // 16 - 31
        8'bzzzz1zz: pos = 3'b010; // 8 - 15
        8'bzzzzzz1: pos = 3'b001; // 1 - 7
        default: pos = 3'b000; // 0
    endcase
end

endmodule
