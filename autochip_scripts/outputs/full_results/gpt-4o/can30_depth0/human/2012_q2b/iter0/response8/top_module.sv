module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    
    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y1 (input to state flip-flop y[1]) conditions
    // y[0] is A
    // y[1] is B
    // y[2] is C
    // y[3] is D
    // y[4] is E
    // y[5] is F
    assign Y1 = (y[0] & w) | (y[5] & w);
    
    // Y3 (input to state flip-flop y[3]) conditions
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w) | (y[3] & (w ^ 1'b1));

endmodule
