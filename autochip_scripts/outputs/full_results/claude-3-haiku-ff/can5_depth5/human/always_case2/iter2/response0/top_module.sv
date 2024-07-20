module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    case (1'b1)
        in[3]: pos = 2'b11;
        in[2]: pos = 2'b10;
        in[1]: pos = 2'b01;
        in[0]: pos = 2'b00;
        default: pos = 2'b00; // If none of the input bits are high, output zero
    endcase
end

endmodule
