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
            A: Y2 = 0; // For state A, Y2 is 0
            B: Y2 = (w) ? 1 : 0; // For state B, Y2 is 0 if w=0, 1 if w=1
            C: Y2 = (w) ? 1 : 0; // For state C, Y2 is 0 if w=0, 1 if w=1
            D: Y2 = 1; // For state D, Y2 is 1
            E: Y2 = 1; // For state E, Y2 is 1
            F: Y2 = 0; // For state F, Y2 is 0
            default: Y2 = 0; // Default case
        endcase
    end

endmodule
