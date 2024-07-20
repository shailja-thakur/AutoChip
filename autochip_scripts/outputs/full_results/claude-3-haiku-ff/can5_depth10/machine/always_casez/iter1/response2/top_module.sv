module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b11111111: pos = 3'h7;
        8'b01111111: pos = 3'h6;
        8'b00111111: pos = 3'h5;
        8'b00011111: pos = 3'h4;
        8'b00001111: pos = 3'h3;
        8'b00000111: pos = 3'h2;
        8'b00000011: pos = 3'h1;
        8'b00000001: pos = 3'h0;
        default: pos = 3'h0;
    endcase
end

endmodule
