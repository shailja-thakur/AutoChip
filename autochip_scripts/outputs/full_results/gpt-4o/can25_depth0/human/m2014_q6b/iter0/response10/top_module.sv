module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case(y)
            // State A (000)
            3'b000: Y2 = 1'b0;  // y[2] is 0 for state A (irrespective of 'w')
            
            // State B (001)
            3'b001: Y2 = w; // Next state y[2] depends on input 'w'
            
            // State C (010)
            3'b010: Y2 = 1'b0;  // y[2] is 0 for state C (irrespective of 'w')
            
            // State D (011)
            3'b011: Y2 = 1'b0;  // y[2] is 0 for state D (irrespective of 'w')
            
            // State E (100)
            3'b100: Y2 = 1'b0;  // y[2] is 0 for state E (irrespective of 'w')
            
            // State F (101)
            3'b101: Y2 = 1'b0; // y[2] is 0 for state F (irrespective of 'w')
            
            // Default case to handle unexpected values
            default: Y2 = 1'b0;
        endcase
    end
endmodule
