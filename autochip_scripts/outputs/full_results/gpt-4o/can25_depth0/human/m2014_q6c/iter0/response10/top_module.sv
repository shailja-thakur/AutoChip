module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @(*) begin
        // Default values for Y2 and Y4
        Y2 = 0;
        Y4 = 0;
        
        // State transition logic
        case (y)
            6'b000001: begin // State A
                if (!w)
                    Y2 = 1'b1; // transition to state B
                // else stay in state A (Y2, Y4 = 0, 0)
            end
            
            6'b000010: begin // State B
                if (!w)
                    Y4 = 1'b1; // transition to state C
                else
                    Y2 = 1'b1; // transition to state D
            end
            
            6'b000100: begin // State C
                if (!w)
                    ; // transition to state E (Y2, Y4 = 0, 0)
                else
                    Y2 = 1'b1; // transition to state D
            end
            
            6'b001000: begin // State D
                if (!w)
                    ; // transition to state F (Y2, Y4 = 0, 0)
                else
                    ; // transition to state A (Y2, Y4 = 0, 0)
            end
            
            6'b010000: begin // State E
                if (!w)
                    ; // stay in state E (Y2, Y4 = 0, 0)
                else
                    Y2 = 1'b1; // transition to state D
            end
            
            6'b100000: begin // State F
                if (!w)
                    Y4 = 1'b1; // transition to state C
                else
                    Y2 = 1'b1; // transition to state D
            end
            
            default: begin
                // Default case if y is not a valid one-hot state
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end

endmodule
