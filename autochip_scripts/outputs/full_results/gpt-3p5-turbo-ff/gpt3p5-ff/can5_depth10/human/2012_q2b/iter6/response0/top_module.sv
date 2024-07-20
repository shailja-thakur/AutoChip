module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] y_reg;

always @(posedge w) begin
    case (y_reg)
        6'b000001: y_reg <= 6'b000010;
        6'b000010: y_reg <= 6'b001000;
        6'b000100: y_reg <= 6'b010000;
        6'b001000: y_reg <= 6'b100000;
        6'b010000: y_reg <= 6'b001000;
        6'b100000: y_reg <= 6'b000001;
        default: y_reg <= 'b0;
    endcase
end

assign Y1 = y_reg[1];
assign Y3 = y_reg[3];

endmodule
