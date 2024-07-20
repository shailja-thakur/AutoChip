module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    // State encodings
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    // Y2 is the next state B (000010) in one-hot encoding
    // Y2 is high when we need to transition to state B
    // Transition to B conditions are:
    // - From state A with input w=0
    
    assign Y2 = (y == A && w == 0);
    
    // Y4 is the next state D (001000) in one-hot encoding
    // Y4 is high when we need to transition to state D
    // Transition to D conditions are:
    // - From state B with input w=1
    // - From state C with input w=1
    // - From state D with input w=1
    // - From state E with input w=1
    // - From state F with input w=1
    
    assign Y4 = (y == B && w == 1) ||
                (y == C && w == 1) ||
                (y == D && w == 1) ||
                (y == E && w == 1) ||
                (y == F && w == 1);

endmodule
