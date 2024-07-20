module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0;                      // State A -> Y2 is 0 (always)
            3'b001: Y2 = w;                         // State B -> Y2 is w
            3'b010: Y2 = 1'b0;                      // State C -> Y2 is 0 (always)
            3'b011: Y2 = 1'b0;                      // State D -> Y2 is 0 (always)
            3'b100: Y2 = 1'b0;                      // State E -> Y2 is 0 (always)
            3'b101: Y2 = 1'b0;                      // State F -> Y2 is 0 (always)
            default: Y2 = 1'b0;                     // Default case for safety
        endcase
    end
    
endmodule
