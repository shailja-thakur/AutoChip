module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    // Define states for readability
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 1'b0; // y[2] is 0 in state A
            B: Y2 = (w == 1'b0) ? 1'b0 : 1'b1;
            C: Y2 = 1'b0; // y[2] is 0 in state C
            D: Y2 = 1'b1; // y[2] is 1 in state D
            E: Y2 = 1'b1; // y[2] is 1 in state E
            F: Y2 = 1'b1; // y[2] is 1 in state F
            default: Y2 = 1'b0; // Default case to avoid latches
        endcase
    end

endmodule
