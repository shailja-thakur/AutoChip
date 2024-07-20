module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    // Compute the next state for y[1] (B state) and y[3] (D state)
    assign Y1 = (y == A && w) || (y == D && w);
    assign Y3 = (y == B && !w) || (y == C && !w) || (y == E && !w) || (y == F && !w);

endmodule
