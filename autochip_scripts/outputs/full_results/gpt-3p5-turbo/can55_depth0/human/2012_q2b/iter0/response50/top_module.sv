module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    
    reg Y1;
    reg Y3;
    
    always @ (y or w)
        case (y)
            6'b000001: begin
                case(w)
                    1'b1: Y1 <= 1'b0;
                    1'b0: Y1 <= 1'b0;
                endcase
                Y3 <= 1'b0;
            end
            6'b000010: begin
                case(w)
                    1'b1: Y1 <= 1'b0;
                    1'b0: Y1 <= 1'b1;
                endcase
                Y3 <= 1'b0;
            end
            6'b000100: begin
                case(w)
                    1'b1: Y1 <= 1'b1;
                    1'b0: Y1 <= 1'b0;
                endcase
                Y3 <= 1'b0;
            end
            6'b001000: begin
                case(w)
                    1'b1: Y1 <= 1'b1;
                    1'b0: Y1 <= 1'b0;
                endcase
                Y3 <= 1'b1;
            end
            6'b010000: begin
                case(w)
                    1'b1: Y1 <= 1'b0;
                    1'b0: Y1 <= 1'b0;
                endcase
                Y3 <= 1'b0;
            end
            6'b100000: begin
                case(w)
                    1'b1: Y1 <= 1'b0;
                    1'b0: Y1 <= 1'b0;
                endcase
                Y3 <= 1'b0;
            end
        endcase
    
    assign Y1 = Y1;
    assign Y3 = Y3;
    
endmodule
