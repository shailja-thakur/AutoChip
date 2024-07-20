module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b0000_0001: pos = 3'b000;
        8'b0000_001z: pos = 3'b001;
        8'b0000_01zz: pos = 3'b010;
        8'b0000_1zzz: pos = 3'b011;
        8'b0001_zzzz: pos = 3'b100;
        8'b001z_zzzz: pos = 3'b101;
        8'b01zz_zzzz: pos = 3'b110;
        8'b1zzz_zzzz: pos = 3'b111;
        default: pos = 3'b000;
    endcase
end

endmodule
