module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A
            3'b001: Y2 = (w) ? 1'b1 : 1'b0; // State B -> A or C
            3'b010: Y2 = (w) ? 1'b1 : 1'b0; // State C -> D or E
            3'b011: Y2 = (w) ? 1'b0 : 1'b1; // State D -> A or F
            3'b100: Y2 = 1'b1; // State E
            3'b101: Y2 = (w) ? 1'b1 : 1'b0; // State F -> D or C
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
