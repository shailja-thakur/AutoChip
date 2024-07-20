module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

reg [5:0] y_reg;

always @(posedge w) begin
    case (y_reg)
        6'b000001: y_reg <= 6'b000010;
        6'b000010: y_reg <= 6'b000100;
        6'b000100: y_reg <= 6'b001000;
        6'b001000: y_reg <= 6'b010000;
        6'b010000: y_reg <= 6'b001000;
        6'b100000: y_reg <= 6'b000100;
        default: y_reg <= y;
    endcase
end

always @(y_reg) begin
    Y1 = y_reg[1];
    Y3 = y_reg[3];
end

endmodule
