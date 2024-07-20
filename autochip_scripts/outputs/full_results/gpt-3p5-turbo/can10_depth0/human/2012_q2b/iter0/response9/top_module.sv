module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    
    reg Y1_reg, Y3_reg;
    
    always @ (posedge w)
    begin
        case(y)
            6'b000001:   // A
                begin
                    Y1_reg <= 1'b1;
                    Y3_reg <= 1'b0;
                end
            6'b000010:   // B
                begin
                    Y1_reg <= 1'b1;
                    Y3_reg <= 1'b0;
                end
            6'b000100:   // C
                begin
                    Y1_reg <= 1'b1;
                    Y3_reg <= 1'b1;
                end
            6'b001000:   // D
                begin
                    Y1_reg <= 1'b0;
                    Y3_reg <= 1'b0;
                end
            6'b010000:   // E
                begin
                    Y1_reg <= 1'b0;
                    Y3_reg <= 1'b1;
                end
            6'b100000:   // F
                begin
                    Y1_reg <= 1'b1;
                    Y3_reg <= 1'b1;
                end
            default:    // stay in same state
                begin
                    Y1_reg <= Y1_reg;
                    Y3_reg <= Y3_reg;
                end
        endcase
    end

    assign Y1 = Y1_reg;
    assign Y3 = Y3_reg;
    
endmodule
