module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b11111110: pos = 3'h0;
        8'b11111101: pos = 3'h1;
        8'b11111011: pos = 3'h2;
        8'b11110111: pos = 3'h3;
        8'b11101111: pos = 3'h4;
        8'b11011111: pos = 3'h5;
        8'b10111111: pos = 3'h6;
        8'b01111111: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
