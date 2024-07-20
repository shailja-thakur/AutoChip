module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    case(in)
        8'b00000001: pos = 1;
        8'b00000010: pos = 2;
        8'b00000100: pos = 3;
        8'b0000010x: pos = 4;
        8'b00001xxx: pos = 5;
        8'b0001xxxx: pos = 6;
        8'b001xxxxx: pos = 7;
        8'b01xxxxxx: pos = 8;
        8'b1xxxxxxx: pos = 9;
        default: pos = 0;
    endcase
end

endmodule
