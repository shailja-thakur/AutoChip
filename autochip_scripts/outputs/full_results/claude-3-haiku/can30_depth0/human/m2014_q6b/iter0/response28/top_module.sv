module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000, 3'b100: // State A, State E
            Y2 = w;
        3'b001, 3'b101: // State B, State F
            Y2 = 1'b0;
        3'b010: // State C
            Y2 = 1'b0;
        3'b011: // State D
            Y2 = w;
        default:
            Y2 = 1'bx; // Default case to handle unexpected states
    endcase
end

endmodule
