module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg Y1_reg, Y3_reg;

always @(posedge w) begin
    case(y)
        6'b000001: begin // A
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b0;
        end
        6'b000010: begin // B
            Y1_reg <= 1'b1;
            Y3_reg <= 1'b0;
        end
        6'b000100: begin // C
            Y1_reg <= 1'b1;
            Y3_reg <= 1'b0;
        end
        6'b001000: begin // D
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b0;
        end
        6'b010000: begin // E
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b1;
        end
        6'b100000: begin // F
            Y1_reg <= 1'b1;
            Y3_reg <= 1'b0;
        end
        default: begin
            Y1_reg <= 1'b0;
            Y3_reg <= 1'b0;
        end
    endcase
end

always @(posedge w) begin
    Y1 <= Y1_reg;
    Y3 <= Y3_reg;
end

endmodule
