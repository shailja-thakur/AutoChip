module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg Y1_reg, Y3_reg;

always @(y or w)
begin
    case(y)
        6'b000001: begin
                        Y1_reg <= (w) ? 1'b0 : Y1_reg;
                        Y3_reg <= (w) ? 1'b0 : Y3_reg;
                    end
        6'b000010: begin
                        Y1_reg <= (w) ? 1'b0 : Y1_reg;
                        Y3_reg <= (w) ? 1'b1 : Y3_reg;
                    end
        6'b000100: begin
                        Y1_reg <= (w) ? 1'b1 : Y1_reg;
                        Y3_reg <= (w) ? 1'b0 : Y3_reg;
                    end
        6'b001000: begin
                        Y1_reg <= (w) ? 1'b0 : Y1_reg;
                        Y3_reg <= (w) ? 1'b0 : Y3_reg;
                    end
        6'b010000: begin
                        Y1_reg <= (w) ? 1'b0 : Y1_reg;
                        Y3_reg <= (w) ? 1'b0 : Y3_reg;
                    end
        6'b100000: begin
                        Y1_reg <= (w) ? 1'b0 : Y1_reg;
                        Y3_reg <= (w) ? 1'b1 : Y3_reg;
                    end
        default:    begin
                        Y1_reg <= Y1_reg;
                        Y3_reg <= Y3_reg;
                    end
    endcase
end

assign Y1 = Y1_reg;
assign Y3 = Y3_reg;

endmodule
