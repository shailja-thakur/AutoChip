module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    case(in)
        8'bxxx0_0001: pos = 3'b000;
        8'bxxx0_0010: pos = 3'b001;
        8'bxxx0_0100: pos = 3'b010;
        8'bxxx0_1000: pos = 3'b011;
        8'bxxx1_0000: pos = 3'b100;
        8'bxx1_0000x: pos = 3'b101;
        8'bx1_0000xx: pos = 3'b110;
        8'b1_0000xxx: pos = 3'b111;
        default: pos = 3'b000;
    endcase
end

endmodule
