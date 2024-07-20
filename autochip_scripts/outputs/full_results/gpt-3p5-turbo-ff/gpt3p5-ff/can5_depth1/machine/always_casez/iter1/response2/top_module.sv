module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @*
    begin
        case(in)
            8'b01xxxxxx: pos = 3'b0;
            8'bx1xxxxxx: pos = 3'b1;
            8'bxx1xxxxx: pos = 3'b2;
			8'bxxx1xxxx: pos = 3'b3;
			8'bxxxx1xxx: pos = 3'b4;
			8'bxxxxx1xx: pos = 3'b5;
			8'bxxxxxx1x: pos = 3'b6;
			8'bxxxxxxx1: pos = 3'b7;
            default: pos = 3'b0;
        endcase
    end
endmodule
