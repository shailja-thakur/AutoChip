module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding based on one-hot mechanics
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    // Y1 is the next state of flip-flop y[1] (State B)
    // Transition conditions:
    // A --1--> B (when y = A and w = 1)
    assign Y1 = (y == A && w == 1'b1);

    // Y3 is the next state of flip-flop y[3] (State D)
    // Transition conditions:
    // B --0--> D (when y = B and w = 0)
    // C --0--> D (when y = C and w = 0)
    // D --0--> A (when y = D and w = 0)  (Resident state is not assigned as D - Assignment only through inspection)
    // E --0--> D (when y = E and w = 0)
    // F --0--> D (when y = F and w = 0)
    assign Y3 = (y == B && w == 1'b0) || 
                (y == C && w == 1'b0) || 
                (y == E && w == 1'b0) || 
                (y == F && w == 1'b0);

endmodule
