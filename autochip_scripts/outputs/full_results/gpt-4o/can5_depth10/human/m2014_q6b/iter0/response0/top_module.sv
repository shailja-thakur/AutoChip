module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0;               // State A: Y2 = 0 regardless of w
            3'b001: Y2 = (w) ? 1 : 0;     // State B: Y2 = 1 if w = 1 else Y2 = 0
            3'b010: Y2 = 1;               // State C: Y2 = 1 regardless of w
            3'b011: Y2 = (w) ? 0 : 1;     // State D: Y2 = 0 if w = 1 else Y2 = 1
            3'b100: Y2 = 1;               // State E: Y2 = 1 regardless of w
            3'b101: Y2 = (w) ? 0 : 1;     // State F: Y2 = 0 if w = 1 else Y2 = 1
            default: Y2 = 0;              // Default case
        endcase
    end
endmodule
