module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define states for clarity
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = (w) ? A[2] : B[2];
            B: Y2 = (w) ? D[2] : C[2];
            C: Y2 = (w) ? D[2] : E[2];
            D: Y2 = (w) ? A[2] : F[2];
            E: Y2 = (w) ? D[2] : E[2];
            F: Y2 = (w) ? D[2] : C[2];
            default: Y2 = 1'b0; // default case to handle unexpected situations
        endcase
    end
endmodule
