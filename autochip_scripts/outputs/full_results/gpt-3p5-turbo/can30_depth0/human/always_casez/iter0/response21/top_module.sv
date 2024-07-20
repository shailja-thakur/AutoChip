module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(in)
begin
    case(in)
        8'b00000001: pos = 3'b0;  // bit[0] is high
        8'b00000010: pos = 3'b1;  // bit[1] is high
        8'b00000100: pos = 3'b2;  // bit[2] is high
        8'b00001000: pos = 3'b3;  // bit[3] is high
        8'b00010000: pos = 3'b4;  // bit[4] is high
        8'b00100000: pos = 3'b5;  // bit[5] is high
        8'b01000000: pos = 3'b6;  // bit[6] is high
        8'b10000000: pos = 3'b7;  // bit[7] is high
        default: pos = 3'b0;  // no bits are high
    endcase
end

endmodule
