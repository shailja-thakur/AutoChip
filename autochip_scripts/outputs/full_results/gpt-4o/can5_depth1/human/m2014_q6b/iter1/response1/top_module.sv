module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // State A
            3'b001: Y2 = 1'b0; // State B (next state is either A or C, both have y[2] = 0)
            3'b010: Y2 = 1'b1; // State C (next state is either D or E, D has y[2] = 1 and E has y[2] = 1)
            3'b011: Y2 = 1'b1; // State D (next state is either A or F, both have y[2] = 0 or 1)
            3'b100: Y2 = 1'b0; // State E (next state is E or D, E has y[2] = 1, D has y[2] = 1)
            3'b101: Y2 = 1'b0; // State F (next state is either C or D, C has y[2] = 1 and D has y[2] = 1)
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
