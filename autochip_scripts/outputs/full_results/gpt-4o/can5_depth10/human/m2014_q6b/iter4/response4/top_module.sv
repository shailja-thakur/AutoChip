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
            A: Y2 = w ? 1'b0 : 1'b0; // w does not affect state transition for A, Y2 is always 0
            B: Y2 = w ? 1'b1 : 1'b0; // w affects state transition for B, Y2 is 1 if w is 1 
            C: Y2 = w ? 1'b1 : 1'b1; // w does not affect state transition for C, Y2 is always 1
            D: Y2 = w ? 1'b0 : 1'b1; // w affects state transition for D, Y2 is 0 if w is 1 
            E: Y2 = w ? 1'b1 : 1'b0; // w affects state transition for E, Y2 is 1 if w is 1 
            F: Y2 = w ? 1'b1 : 1'b0; // w affects state transition for F, Y2 is 1 if w is 1 
            default: Y2 = 1'b0; // default case should never be hit
        endcase
    end

endmodule
