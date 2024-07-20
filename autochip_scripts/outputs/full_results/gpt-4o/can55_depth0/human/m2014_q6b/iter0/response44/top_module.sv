module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A -> Y2 = 0
            3'b001: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; // State B -> Y2 = 0 for B to C, 1 for B to D
            3'b010: Y2 = (w == 1'b0) ? 1'b1 : 1'b1; // State C -> Y2 = 1 for both E and D
            3'b011: Y2 = (w == 1'b0) ? 1'b1 : 1'b0; // State D -> Y2 = 1 for D to F, 0 for D to A
            3'b100: Y2 = 1'b1; // State E -> Y2 = 1
            3'b101: Y2 = 1'b0; // State F -> Y2 = 0
            default: Y2 = 1'b0;
        endcase
    end

endmodule
