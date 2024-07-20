module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

    // State Encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 1'b0; // A -> y[2] = 0
            B: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; // B: (0->C, 1->D) -> y[2] = next D (1) or C (0)
            C: Y2 = (w == 1'b0) ? 1'b1 : 1'b1; // C: (0->E, 1->D) -> y[2] = E, D (both have y[2] = 1)
            D: Y2 = (w == 1'b0) ? 1'b1 : 1'b0; // D: (0->F, 1->A) -> y[2] = F (1) or A (0)
            E: Y2 = 1'b1; // E -> y[2] = 1
            F: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; // F: (0->C, 1->D) -> y[2] = C (0) or D (1)
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
