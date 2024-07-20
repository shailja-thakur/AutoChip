module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: // State A
            Y2 = w ? 1'b0 : 1'b1; // Corrected to transition to state B on w=1
        3'b001: // State B
            Y2 = w ? 1'b1 : 1'b0; // Corrected to transition to state C on w=0
        3'b010: // State C
            Y2 = w ? 1'b1 : 1'b0; // Corrected to transition to state D on w=1
        3'b011: // State D
            Y2 = w ? 1'b0 : 1'b1; // Corrected to transition to state A on w=1
        3'b100: // State E
            Y2 = 1'b0; // Remains in state E
        3'b101: // State F
            Y2 = w ? 1'b1 : 1'b0; // Corrected to transition to state C on w=0
        default:
            Y2 = 1'bx;
    endcase
end

endmodule
