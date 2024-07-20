module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);
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
            A: Y2 = 0; // State A is 3'b000
            B: Y2 = w ? 1 : 0; // State B transitions
            C: Y2 = w ? 1 : 1; // State C is 3'b010
            D: Y2 = 1; // State D is 3'b011
            E: Y2 = 1; // State E is 3'b100
            F: Y2 = w ? 1 : 0; // State F transitions
            default: Y2 = 0; // Default case
        endcase
    end
endmodule
