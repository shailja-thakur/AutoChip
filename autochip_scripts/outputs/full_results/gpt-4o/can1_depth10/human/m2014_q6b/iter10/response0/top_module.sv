module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0; // State A: Y2 = 0
            3'b001: Y2 = 0; // State B: Y2 = 0
            3'b010: Y2 = 0; // State C: Y2 = 0
            3'b011: Y2 = 0; // State D: Y2 = 0
            3'b100: Y2 = 1; // State E: Y2 = 1
            3'b101: Y2 = 1; // State F: Y2 = 1
            default: Y2 = 1'b0;
        endcase
    end

    always @(*) begin
        case (y)
            3'b000: begin // State A
                if (w) 
                    Y2 = 1'b0; // Stay in A
                else 
                    Y2 = 1'b0; // Move to B
            end
            3'b001: begin // State B
                if (w) 
                    Y2 = 1'b0; // Move to D
                else 
                    Y2 = 1'b0; // Move to C
            end
            3'b010: begin // State C
                if (w) 
                    Y2 = 1'b0; // Move to D
                else 
                    Y2 = 1'b1; // Move to E
            end
            3'b011: begin // State D
                if (w) 
                    Y2 = 1'b0; // Move to A
                else 
                    Y2 = 1'b1; // Move to F
            end
            3'b100: begin // State E
                if (w) 
                    Y2 = 1'b0; // Move to D
                else 
                    Y2 = 1'b1; // Stay in E
            end
            3'b101: begin // State F
                if (w) 
                    Y2 = 1'b0; // Move to D
                else 
                    Y2 = 1'b0; // Move to C
            end
            default: Y2 = 1'b0;
        endcase
    end

endmodule
