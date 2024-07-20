module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // state definitions for readability
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;
    
    assign Y1 = (y == A && w) ||  // from state A with input w=1
                (y == F && w);   // from state F with input w=1
                
    assign Y3 = (y == B && !w) || // from state B with input w=0
                (y == C && !w) || // from state C with input w=0
                (y == F && !w);   // from state F with input w=0

endmodule
