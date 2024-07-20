module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    case (in)
        4'b0000: pos = 2'b00;
        4'b0001: pos = 2'b00;
        4'b0010: pos = 2'b01;
        4'b0100: pos = 2'b10;
        4'b1000: pos = 2'b11;
        default: begin
            if (in[3]) pos = 2'b11;
            else if (in[2]) pos = 2'b10;
            else if (in[1]) pos = 2'b01;
            else if (in[0]) pos = 2'b00;
            else pos = 2'b00; // if none of the input bits are high, output zero
        end
    endcase
end

endmodule
