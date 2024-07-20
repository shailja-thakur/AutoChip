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
            A: Y2 = 1'b0; // State A: y[2]=0
            B: if (w == 1'b0) Y2 = 1'b0; else Y2 = 1'b1; // State B
            C: if (w == 1'b0) Y2 = 1'b1; else Y2 = 1'b1; // State C
            D: if (w == 1'b0) Y2 = 1'b1; else Y2 = 1'b0; // State D
            E: Y2 = 1'b0; // State E: y[2]=0
            F: Y2 = 1'b1; // State F: y[2]=1
            default: Y2 = 1'b0; // Default state
        endcase
    end
endmodule
