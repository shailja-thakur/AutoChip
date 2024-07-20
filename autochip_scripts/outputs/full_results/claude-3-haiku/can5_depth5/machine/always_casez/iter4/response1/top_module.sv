module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    casez (in)
        8'b11111111: pos = 3'b111;
        8'b1???????: pos = 3'b000;
        8'b01??????: pos = 3'b001;
        8'b001?????: pos = 3'b010;
        8'b0001????: pos = 3'b011;
        8'b00001???: pos = 3'b100;
        8'b000000??: pos = 3'b101;
        8'b0000000?: pos = 3'b110;
        default: pos = 3'b000;
    endcase
end

endmodule
