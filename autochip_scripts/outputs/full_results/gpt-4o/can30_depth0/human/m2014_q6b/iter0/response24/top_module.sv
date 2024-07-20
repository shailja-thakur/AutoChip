module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0; // State A
            3'b001: Y2 = ~w; // State B, transitions to C (next-state 010) or D (next-state 011)
            3'b010: Y2 = 0; // State C
            3'b011: Y2 = 1; // State D
            3'b100: Y2 = 1; // State E
            3'b101: Y2 = 0; // State F
            default: Y2 = 0; // Default case to handle any unexpected state
        endcase
    end
endmodule
