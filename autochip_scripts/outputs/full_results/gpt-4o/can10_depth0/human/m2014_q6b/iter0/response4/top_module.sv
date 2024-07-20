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

    always @(*) begin
        case (y)
            A: Y2 = 1'b0; // Next state will be A or B, both have y[2] = 0
            B: Y2 = w ? 1'b1 : 1'b0; // Next state D (011) if w = 1, else C (010), hence y[2] = w
            C: Y2 = 1'b1; // Next state will be D or E, both have y[2] = 1
            D: Y2 = w ? 1'b0 : 1'b1; // Next state A (000) if w = 1, else F (101), hence y[2] = ~w
            E: Y2 = 1'b0; // Next state will be E or D, E (100) has y[2] = 1, D (011) has y[2] = 0
            F: Y2 = 1'b0; // Next state will be C or D, C (010) has y[2] = 1, D (011) has y[2] = 1
            default: Y2 = 1'b0;
        endcase
    end

endmodule
