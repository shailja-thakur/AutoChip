module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    reg Y1_reg;
    reg Y3_reg;

    always @(w) begin
        case (y)
            6'b000001: Y1_reg <= 1'b0;
            6'b000010: Y1_reg <= 1'b0;
            6'b000100: Y1_reg <= 1'b0;
            6'b001000: Y1_reg <= 1'b0;
            6'b010000: Y1_reg <= 1'b1;
            6'b100000: Y1_reg <= 1'b1;
            default: Y1_reg <= 1'b0;
        endcase

        case (y)
            6'b000001: Y3_reg <= 1'b0;
            6'b000010: Y3_reg <= 1'b0;
            6'b000100: Y3_reg <= 1'b1;
            6'b001000: Y3_reg <= 1'b1;
            6'b010000: Y3_reg <= 1'b0;
            6'b100000: Y3_reg <= 1'b0;
            default: Y3_reg <= 1'b0;
        endcase
    end

    always @* begin
        case (Y1_reg)
            1'b0: Y1 = 1'b0;
            1'b1: Y1 = 1'b1;
            default: Y1 = 1'b0;
        endcase

        case (Y3_reg)
            1'b0: Y3 = 1'b0;
            1'b1: Y3 = 1'b1;
            default: Y3 = 1'b0;
        endcase
    end

endmodule
