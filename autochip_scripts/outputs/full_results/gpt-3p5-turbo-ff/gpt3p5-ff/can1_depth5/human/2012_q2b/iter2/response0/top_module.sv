module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [1:0] Y_reg;

always @(posedge w) begin
    case (y)
        6'b000001: Y_reg <= 2'b00;
        6'b000010: Y_reg <= 2'b01;
        6'b000100: Y_reg <= 2'b10;
        6'b001000: Y_reg <= 2'b11;
        6'b010000: Y_reg <= 2'b10;
        6'b100000: Y_reg <= 2'b01;
        default: Y_reg <= 2'b00;
    endcase
end

assign Y1 = Y_reg[0];
assign Y3 = Y_reg[1];

endmodule
