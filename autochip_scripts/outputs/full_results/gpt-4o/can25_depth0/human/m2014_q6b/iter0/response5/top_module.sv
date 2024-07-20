module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    // Always block for combinational logic
    always @(*) begin
        case(y)
            3'b000: Y2 = 1'b0; // State A
            3'b001: // State B
                if (w == 1'b0)
                    Y2 = y[2]; // UNDEFINED STATE (does not affect y[2])
                else
                    Y2 = 1'b0; // NEXT STATE y = 001 -> D => y[2] = 0
            3'b010: // State C
                if (w == 1'b0)
                    Y2 = y[2]; // UNDEFINED STATE (does not affect y[2])
                else
                    Y2 = 1'b0; // NEXT STATE y = 010 -> D => y[2] = 0
            3'b011: // State D
                if (w == 1'b0)
                    Y2 = 1'b1; // State F -> next state has Y2 = 1
                else
                    Y2 = 1'b0; // State A -> next state has Y2 = 0 
            3'b100: Y2 = 1'b1; // State E
            3'b101: // State F
                if (w == 1'b0)
                    Y2 = 1'b0; // State C
                else
                    Y2 = 1'b0; // State D
            default: Y2 = 1'b0; // Default case
        endcase
    end
    
endmodule
