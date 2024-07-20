module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State Encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Output logic for Y1
    assign Y1 = (y == A && w)    ? 1 :
                (y == B && !w)   ? 1 :
                0;

    // Output logic for Y3
    assign Y3 = (y == C && !w)   ? 1 :
                (y == D && !w)   ? 1 :
                (y == E && !w)   ? 1 :
                (y == F && !w)   ? 1 :
                0;

endmodule
