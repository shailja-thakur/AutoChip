module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Define each state for better readability
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Derive the next state y1 (B state) logic
    assign Y1 = (y == A && w) || (y == F && w);

    // Derive the next state y3 (D state) logic
    assign Y3 = (y == B && !w) || (y == C && !w) || (y == D && !w) || (y == E && !w) || (y == F && !w);

endmodule
