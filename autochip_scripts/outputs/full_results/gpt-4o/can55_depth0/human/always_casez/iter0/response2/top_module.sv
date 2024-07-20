module top_module(
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casez (in)
            8'b00000001: pos = 3'b000;
            8'b0000001?: pos = 3'b001;
            8'b000001??: pos = 3'b010;
            8'b00001???: pos = 3'b011;
            8'b0001????: pos = 3'b100;
            8'b001?????: pos = 3'b101;
            8'b01??????: pos = 3'b110;
            8'b1???????: pos = 3'b111;
            default:     pos = 3'b000; // when all bits are low
        endcase
    end
endmodule
