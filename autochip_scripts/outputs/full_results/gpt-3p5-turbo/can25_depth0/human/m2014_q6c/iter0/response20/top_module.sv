module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    reg Y2;
    reg Y4;

    always @(*) begin
        case (y)
            7'b000001: begin
                // State A
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b0;
                
                Y4 = 1'b0;
            end
            
            7'b000010: begin
                // State B
                if (w)
                    Y4 = 1'b1;
                else
                    Y4 = 1'b0;
                
                Y2 = 1'b0;
            end
            
            7'b000100: begin
                // State C
                if (w)
                    Y4 = 1'b0;
                else
                    Y4 = 1'b1;
                
                Y2 = 1'b0;
            end
            
            7'b001000: begin
                // State D
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b0;
                
                Y4 = 1'b0;
            end
            
            7'b010000: begin
                // State E
                if (w)
                    Y2 = 1'b1;
                else
                    Y2 = 1'b0;
                
                Y4 = 1'b0;
            end
            
            7'b100000: begin
                // State F
                if (w)
                    Y4 = 1'b0;
                else
                    Y4 = 1'b1;
                
                Y2 = 1'b0;
            end
        endcase
    end

endmodule
