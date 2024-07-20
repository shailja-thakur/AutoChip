module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @* begin
        pos <= 3'b000;
        case (in)
            8'b1zzzzzzz: pos <= 3'b000;
            8'bz1zzzzzz: pos <= 3'b001;
            8'bz11zzzzz: pos <= 3'b010;
            8'bz111zzzz: pos <= 3'b011;
            8'bz1111zzz: pos <= 3'b100;
            8'bz11111zz: pos <= 3'b101;
            8'bz111111z: pos <= 3'b110;
            8'bz1111111: pos <= 3'b111;
        endcase
    end
endmodule
