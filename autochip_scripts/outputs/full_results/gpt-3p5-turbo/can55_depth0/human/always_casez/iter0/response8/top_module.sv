module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        case (in)
            8'b00000001: pos = 3'b0;
            8'b00000010: pos = 3'b1;
            8'b00000100: pos = 3'b2;
            8'b00001000: pos = 3'b3;
            8'b00010000: pos = 3'b4;
            8'b00100000: pos = 3'b5;
            8'b01000000: pos = 3'b6;
            8'b10000000: pos = 3'b7;
            default: pos = 3'b0;
        endcase
    end
endmodule
