module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Next-state logic for y[2]
    always @(*) begin
        case (y)
            3'b000: Y2 = 0; // State A
            3'b001: Y2 = w; // State B, next state depends on input w
            3'b010: Y2 = 0; // State C
            3'b011: Y2 = (w == 0) ? 0 : 1; // State D, next state depends on input w
            3'b100: Y2 = 0; // State E
            3'b101: Y2 = (w == 0) ? 1 : 0; // State F, next state depends on input w
            default: Y2 = 0; // Default state
        endcase
    end

endmodule
