module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A
            3'b001: Y2 = (w == 0) ? 1'b0 : 1'b1; // State B, goes to C (0) or D (1)
            3'b010: Y2 = (w == 0) ? 1'b0 : 1'b1; // State C, goes to E (0) or D (1)
            3'b011: Y2 = (w == 0) ? 1'b1 : 1'b0; // State D, goes to F (0) or A (1)
            3'b100: Y2 = 1'b1; // State E
            3'b101: Y2 = 1'b0; // State F, always 0
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
