module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @* begin
    case(in)
        4'b0000: pos = 0;
        4'b0001: pos = 1;
        4'b0010: pos = 2;
        4'b0011: pos = 3;
        4'b0100: pos = 4;
        4'b0101: pos = 5;
        4'b0110: pos = 6;
        4'b0111: pos = 7;
        4'b1000: pos = 8;
        4'b1001: pos = 9;
        4'b1010: pos = 10;
        4'b1011: pos = 11;
        4'b1100: pos = 12;
        4'b1101: pos = 13;
        4'b1110: pos = 14;
        4'b1111: pos = 15;
    endcase
end

endmodule
