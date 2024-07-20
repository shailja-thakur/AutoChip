module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @(*) begin
        case(in)
            8'b00000001: pos = 0;
            8'b00000010: pos = 1;
            8'b00000100: pos = 2;
            8'b00001000: pos = 3;
            8'b00010000: pos = 4;
            8'b00100000: pos = 5;
            8'b01000000: pos = 6;
            8'b10000000: pos = 7;
            default: pos = 0;
        endcase
    end

endmodule
