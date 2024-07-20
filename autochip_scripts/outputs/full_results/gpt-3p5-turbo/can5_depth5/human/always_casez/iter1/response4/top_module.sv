module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @* begin
        casez(in)
            8'b00000001: pos = 1;
            8'b00000011: pos = 2;
            8'b00000111: pos = 3;
            8'b00001111: pos = 4;
            8'b00011111: pos = 5;
            8'b00111111: pos = 6;
            8'b01111111: pos = 7;
            8'b11111111: pos = 8;
            default: pos = 0;
        endcase
    end

endmodule
