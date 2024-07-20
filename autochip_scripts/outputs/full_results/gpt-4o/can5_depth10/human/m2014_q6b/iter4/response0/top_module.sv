module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define the states
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 1'b0; // A
            B: Y2 = w ? 1'b1 : 1'b0; // B: If w=0 -> C (y[2]=1'b0), If w=1 -> D (y[2]=1'b1)
            C: Y2 = w ? 1'b1 : 1'b1; // C: If w=0 -> E (y[2]=1'b1), If w=1 -> D (y[2]=1'b1)
            D: Y2 = w ? 1'b0 : 1'b1; // D: If w=0 -> F (y[2]=1'b1), If w=1 -> A (y[2]=1'b0)
            E: Y2 = 1'b0; // E
            F: Y2 = 1'b0; // F
            default: Y2 = 1'b0; // default case should never be hit
        endcase
    end

endmodule
