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
        6'b000010: y_reg <= 6'b001000;
        6'b000100: y_reg <= 6'b010000;
        6'b001000: y_reg <= 6'b100000;
        6'b010000: y_reg <= 6'b001000;
        6'b100000: y_reg <= 6'b000001;
        default: y_reg <= 'b0;
    endcase
end

always @(y_reg) begin
    case (y_reg)
        6'b000001: begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b000010: begin
            Y1 <= 1'b0;
            Y3 <= 1'b1;
        end
        6'b000100: begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b001000: begin
            Y1 <= 1'b0;
            Y3 <= 1'b1;
        end
        6'b010000: begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b100000: begin
            Y1 <= 1'b1;
            Y3 <= 1'b0;
        end
        default: begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
    endcase
end

endmodule
