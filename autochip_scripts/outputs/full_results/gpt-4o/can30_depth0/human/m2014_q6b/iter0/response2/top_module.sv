module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

	// State encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    // Next-state logic for y[2]
    always @(*) begin
        case (y)
            A: Y2 = 0; // A transitions to either A or B, both have y[2] = 0
            B: Y2 = (w == 0) ? 1 : 1; // Both transitions (B -> C and B -> D) have y[2] = 1
            C: Y2 = (w == 0) ? 1 : 1; // Both transitions (C -> E and C -> D) have y[2] = 1
            D: Y2 = (w == 0) ? 1 : 0; // D transitions to F (y[2] = 1) or A (y[2] = 0)
            E: Y2 = 1; // E transitions to either E or D, both have y[2] = 1
            F: Y2 = 0; // F transitions to either C (y[2] = 0) or D (y[2] = 0)
            default: Y2 = 0; // Default case, should not occur
        endcase
    end

endmodule
