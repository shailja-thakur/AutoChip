module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @ (*) begin
    case(a)
        0: q = 16'b10010001011010;
        1: q = 16'b1010111000010000;
        2: q = 16'b100111110100;
        3: q = 16'b1011001011110110;
        4: q = 16'b1000000101010;
        5: q = 16'b1100010010001110;
        6: q = 16'b1100010011111110;
        7: q = 16'b101111000111001;
        default: q = 16'b0;
    endcase
end

endmodule
