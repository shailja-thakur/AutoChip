module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    case (in)
        8'b11111110: pos = 3'b111;
        8'b11111101: pos = 3'b110;
        8'b11111011: pos = 3'b101;
        8'b11110111: pos = 3'b100;
        8'b11101111: pos = 3'b011;
        8'b11011111: pos = 3'b010;
        8'b10111111: pos = 3'b001;
        8'b01111111: pos = 3'b000;
        default: pos = 3'b000; // Corrected the default case to set pos to 3'b000
    endcase
end

endmodule
