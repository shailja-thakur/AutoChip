module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    case (in)
        8'b11111111: pos = 3'b111;
        8'b01111111: pos = 3'b110;
        8'b00111111: pos = 3'b101;
        8'b00011111: pos = 3'b100;
        8'b00001111: pos = 3'b011;
        8'b00000111: pos = 3'b010;
        8'b00000011: pos = 3'b001;
        8'b00000001: pos = 3'b000;
        default: pos = 3'b000;
    endcase
end

endmodule
