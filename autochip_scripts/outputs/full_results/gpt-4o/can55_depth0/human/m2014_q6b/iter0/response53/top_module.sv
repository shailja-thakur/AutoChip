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

    // Next state logic for y[2]
    always @(*) begin
        case (y)
            A: Y2 = 1'b0;  // Both transitions from A lead to states with y[2] = 0
            B: Y2 = (w == 0) ? 1'b1 : 1'b1;  // Transitions to C or D both have y[2] = 1
            C: Y2 = 1'b0;  // Both transitions from C lead to states with y[2] = 0
            D: Y2 = 1'b1;  // Both transitions from D lead to states with y[2] = 1
            E: Y2 = 1'b1;  // Both transitions from E lead to states with y[2] = 1
            F: Y2 = 1'b0;  // Both transitions from F lead to states with y[2] = 0
            default: Y2 = 1'b0;  // Default safe state
        endcase
    end

endmodule
