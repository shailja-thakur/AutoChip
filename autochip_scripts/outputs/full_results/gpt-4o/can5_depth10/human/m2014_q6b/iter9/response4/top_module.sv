module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define the states and their corresponding codes
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            // State A
            A: if (w) Y2 = A[2]; // Stay in A, Y2 = 0
               else Y2 = B[2];   // Go to B, Y2 = 0

            // State B
            B: if (w) Y2 = D[2]; // Go to D, Y2 = 1
               else Y2 = C[2];   // Go to C, Y2 = 0

            // State C
            C: if (w) Y2 = D[2]; // Go to D, Y2 = 1
               else Y2 = E[2];   // Go to E, Y2 = 1

            // State D
            D: if (w) Y2 = A[2]; // Go to A, Y2 = 0
               else Y2 = F[2];   // Go to F, Y2 = 1

            // State E
            E: if (w) Y2 = D[2]; // Go to D, Y2 = 1
               else Y2 = E[2];   // Stay in E, Y2 = 1

            // State F
            F: if (w) Y2 = D[2]; // Go to D, Y2 = 1
               else Y2 = C[2];   // Go to C, Y2 = 0

            default: Y2 = 1'b0; // Default case
        endcase
    end
endmodule
