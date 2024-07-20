module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b00000001: pos = 3'b000;
        8'b0000001z: pos = 3'b001;
        8'b000001zz: pos = 3'b010;
        8'b00001zzz: pos = 3'b011;
        8'b0001zzzz: pos = 3'b100;
        8'b001zzzzz: pos = 3'b101;
        8'b01zzzzzz: pos = 3'b110;
        8'b1zzzzzzz: pos = 3'b111;
        default: pos = 3'b000;
    endcase
end

endmodule
