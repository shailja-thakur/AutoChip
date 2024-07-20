module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    always @(*) begin
        case (in)
            4'b0000: pos = 2'b00; // in = 0
            4'b0001: pos = 2'b00; // in = 1
            4'b0010: pos = 2'b01; // in = 2
            4'b0011: pos = 2'b00; // in = 3
            4'b0100: pos = 2'b10; // in = 4
            4'b0101: pos = 2'b00; // in = 5
            4'b0110: pos = 2'b01; // in = 6
            4'b0111: pos = 2'b00; // in = 7
            4'b1000: pos = 2'b11; // in = 8
            4'b1001: pos = 2'b00; // in = 9
            4'b1010: pos = 2'b01; // in = 10
            4'b1011: pos = 2'b00; // in = 11
            4'b1100: pos = 2'b10; // in = 12
            4'b1101: pos = 2'b00; // in = 13
            4'b1110: pos = 2'b01; // in = 14
            4'b1111: pos = 2'b00; // in = 15
            default: pos = 2'b00; // default case
        endcase
    end
endmodule
