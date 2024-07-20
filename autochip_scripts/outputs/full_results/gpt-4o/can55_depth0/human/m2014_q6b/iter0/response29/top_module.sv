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

    always @(*) begin
        case (y)
            A: Y2 = 1'b0;  // y[2] = 0 in state A (as state encoding is 000)
            B: if (w == 1'b0)
                   Y2 = 1'b1;  // Next state is C (010) and y[2] = 1
               else
                   Y2 = 1'b1;  // Next state is D (011) and y[2] = 1
            C: Y2 = 1'b0;  // y[2] = 0 in state C (as state encoding is 010)
            D: Y2 = 1'b1;  // y[2] = 1 in state D (as state encoding is 011)
            E: Y2 = 1'b0;  // y[2] = 0 in state E (as state encoding is 100)
            F: if (w == 1'b0)
                   Y2 = 1'b0;  // Next state is C (010) and y[2] = 0
               else
                   Y2 = 1'b1;  // Next state is D (011) and y[2] = 1
            default: Y2 = 1'b0; // Default case to handle undefined states
        endcase
    end

endmodule
