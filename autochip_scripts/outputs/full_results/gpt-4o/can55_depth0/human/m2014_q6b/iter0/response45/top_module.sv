module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

    // Defining states with binary code using 3 bits
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case(y)
            A: Y2 = 0;
            B: Y2 = (w == 1'b0) ? 1 : 0; // Determine next state for B
            C: Y2 = (w == 1'b0) ? 0 : 0; // Determine next state for C
            D: Y2 = (w == 1'b0) ? 1 : 0; // Determine next state for D
            E: Y2 = 1;
            F: Y2 = 1;
            default: Y2 = 0;
        endcase
    end
    
endmodule
