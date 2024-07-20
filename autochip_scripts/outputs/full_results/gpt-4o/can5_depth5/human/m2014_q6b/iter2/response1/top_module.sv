module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0;                      // State A -> Y2 is 0 (always)
            3'b001: Y2 = 1'b0;                      // State B -> Y2 is 0 during transition (next state depends on w)
            3'b010: Y2 = 1'b0;                      // State C -> Y2 is 0 (always)
            3'b011: Y2 = w;                         // State D -> Y2 depends on w for next state
            3'b100: Y2 = 1'b1;                      // State E -> Y2 is 1 (always)
            3'b101: Y2 = w;                         // State F -> Y2 depends on w for next state
            default: Y2 = 1'b0;                     // Default case for safety
        endcase
    end
    
endmodule
