module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b0??????? : pos = 3'h0;
        8'b10??????: pos = 3'h1;
        8'b110?????: pos = 3'h2;
        8'b1110????: pos = 3'h3;
        8'b11110???: pos = 3'h4;
        8'b111110??: pos = 3'h5;
        8'b1111110?: pos = 3'h6;
        8'b11111110: pos = 3'h7;
        default    : pos = 3'h0;
    endcase
end

endmodule
