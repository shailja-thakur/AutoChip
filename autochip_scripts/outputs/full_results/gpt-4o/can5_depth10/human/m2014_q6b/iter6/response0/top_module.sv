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
            B: Y2 = (w == 1) ? 1'b1 : 1'b0; // 0->C, 1->D
            C: Y2 = 1'b0; // 0->E, 1->D (next state Y[2] is '0')
            D: Y2 = 1'b0; // 0->F, 1->A (next state Y[2] is '0')
            E: Y2 = 1'b1; // E (output is '1')
            F: Y2 = 1'b1; // F (output is '1')
            default: Y2 = 1'b0; // default case should never be hit
        endcase
    end
endmodule
