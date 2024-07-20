module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State definitions
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    // Next-state logic
    assign Y2 = (y == A && ~w) || (y == C && ~w);       // state transitions from A to B or from C to D
    assign Y4 = (y == B &&   w) || (y == D && ~w) ||   // state transitions from B to D or from D to F
                (y == E &&   w) || (y == F &&   w);    // state transitions from E to D or from F to D

endmodule
