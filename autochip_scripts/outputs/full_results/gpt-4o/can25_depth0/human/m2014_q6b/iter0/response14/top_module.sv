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
            A: Y2 = 0;
            B: Y2 = (w) ? D[2] : C[2]; // Depending on the value of w, transition to state D or C
            C: Y2 = (w) ? D[2] : E[2]; // Depending on the value of w, transition to state D or E
            D: Y2 = (w) ? A[2] : F[2]; // Depending on the value of w, transition to state A or F
            E: Y2 = 1;
            F: Y2 = 1;
            default: Y2 = 0; // Default case
        endcase
    end
endmodule
