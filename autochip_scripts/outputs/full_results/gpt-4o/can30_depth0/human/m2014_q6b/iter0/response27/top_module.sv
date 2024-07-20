module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0;            // State A: 000 -> y[2] = 0
            3'b001: Y2 = (w == 0) ? 0 : 1; // State B: 001 -> y[2] = 0 if w == 0 else 1
            3'b010: Y2 = (w == 0) ? 1 : 1; // State C: 010 -> y[2] = 1
            3'b011: Y2 = (w == 0) ? 1 : 0; // State D: 011 -> y[2] = 1 if w == 0 else 0
            3'b100: Y2 = 1;            // State E: 100 -> y[2] = 1
            3'b101: Y2 = 0;            // State F: 101 -> y[2] = 0
            default: Y2 = 0;           // Default case
        endcase
    end
endmodule
