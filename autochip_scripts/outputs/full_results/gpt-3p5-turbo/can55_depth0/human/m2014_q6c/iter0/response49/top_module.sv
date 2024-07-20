module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // States
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next-State Logic Equations
    assign Y2 = (y == A || y == F || y == C)? 1'b1 : 1'b0;
    assign Y4 = (y == B || y == D)? 1'b1 : 1'b0;

endmodule
