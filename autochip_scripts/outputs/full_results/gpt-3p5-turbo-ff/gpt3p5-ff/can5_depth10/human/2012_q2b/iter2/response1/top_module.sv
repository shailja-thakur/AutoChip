module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] y_reg;
reg [5:0] next_y_reg;

always @(posedge w) begin
    y_reg <= next_y_reg;
end

always @(y_reg) begin
    case (y_reg)
        6'b000001: next_y_reg = 6'b000010;
        6'b000010: next_y_reg = 6'b000100;
        6'b000100: next_y_reg = 6'b001000;
        6'b001000: next_y_reg = 6'b010000;
        6'b010000: next_y_reg = 6'b100000;
        6'b100000: next_y_reg = 6'b000001;
        default: next_y_reg = y_reg;
    endcase
end

assign Y1 = y_reg[1];
assign Y3 = y_reg[3];

endmodule
