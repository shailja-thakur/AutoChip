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
            A: Y2 = 1'b0; 
            B: Y2 = 1'b0; // y[2] should be 0 for C and D
            C: Y2 = 1'b0; // y[2] should be 0 for E and D
            D: Y2 = 1'b1; // y[2] for state D
            E: Y2 = 1'b1; // y[2] for state E
            F: Y2 = 1'b1; // y[2] for state F and C, D
            default: Y2 = 1'b0; // default case should never be hit
        endcase   
    end
endmodule
