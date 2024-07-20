module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @(*) begin
        case(in)
            8'b00000001: pos = 1;
            8'b00000010: pos = 1;
            8'b00000100: pos = 1;
            8'b00001000: pos = 1;
            8'b00010000: pos = 1;
            8'b00100000: pos = 1;
            8'b01000000: pos = 1;
            8'b10000000: pos = 1;
            8'b00000011: pos = 2;
            8'b00000101: pos = 2;
            8'b00001001: pos = 2;
            8'b00010001: pos = 2;
            8'b00100001: pos = 2;
            8'b01000001: pos = 2;
            8'b10000001: pos = 2;
            default: pos = 0;
        endcase
    end

endmodule
