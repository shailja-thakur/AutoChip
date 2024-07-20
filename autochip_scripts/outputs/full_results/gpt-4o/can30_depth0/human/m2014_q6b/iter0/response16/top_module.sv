module top_module(
    input [3:1] y,  // Current state
    input w,        // Input signal
    output reg Y2   // Next state y[2]
);

    // State encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 0;  // Next state code for just y[2] in A
            B: Y2 = (w == 1) ? 1 : 0;  // B transitions to D on w=1, i.e., 011,y[2]=1, else 010,y[2]=0
            C: Y2 = 0;  // Next state code for just y[2] in C
            D: Y2 = (w == 1) ? 1 : 1;  // D transitions to F on w=0 or A on w=1, both have y[2]=1
            E: Y2 = 1;  // Next state code for just y[2] in E
            F: Y2 = 1;  // Next state code for just y[2] in F
            default: Y2 = 0;  // Default case, should not happen
        endcase
    end

endmodule
