module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b11111110: pos = 3'b111;
        8'b11111100: pos = 3'b110;
        8'b11111000: pos = 3'b101;
        8'b11110000: pos = 3'b100;
        8'b11100000: pos = 3'b011;
        8'b11000000: pos = 3'b010;
        8'b10000000: pos = 3'b001;
        8'b00000001: pos = 3'b000;
        default: pos = 3'b000;
    endcase
end

endmodule
