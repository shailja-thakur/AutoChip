module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    reg Y2_reg, Y4_reg;
    
    always @(y or w) begin
        case (y)
            7'b000001: begin // State A
                Y2_reg <= w ? 1'b0 : 1'b1;
                Y4_reg <= w ? 1'b0 : 1'b0;
            end
            7'b000010: begin // State B
                Y2_reg <= w ? 1'b1 : 1'b0;
                Y4_reg <= w ? 1'b0 : 1'b0;
            end
            7'b000100: begin // State C
                Y2_reg <= w ? 1'b0 : 1'b1;
                Y4_reg <= w ? 1'b0 : 1'b0;
            end
            7'b001000: begin // State D
                Y2_reg <= w ? 1'b1 : 1'b0;
                Y4_reg <= w ? 1'b0 : 1'b0;
            end
            7'b010000: begin // State E
                Y2_reg <= w ? 1'b0 : 1'b1;
                Y4_reg <= w ? 1'b1 : 1'b0;
            end
            7'b100000: begin // State F
                Y2_reg <= w ? 1'b1 : 1'b0;
                Y4_reg <= w ? 1'b1 : 1'b0;
            end
        endcase
    end
    
    assign Y2 = Y2_reg;
    assign Y4 = Y4_reg;
    
endmodule
