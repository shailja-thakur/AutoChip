module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b0000_0001: pos = 3'h0;
        8'b0000_001?: pos = 3'h1;
        8'b0000_01??: pos = 3'h2;
        8'b0000_1???: pos = 3'h3;
        8'b0001_????: pos = 3'h4;
        8'b001?_????: pos = 3'h5;
        8'b01??_????: pos = 3'h6;
        8'b1???_????: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
