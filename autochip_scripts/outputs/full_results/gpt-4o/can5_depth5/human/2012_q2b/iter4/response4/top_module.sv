module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    assign Y1 = (y == 6'b000001 & w) | 
                (y == 6'b100000 & w); // A->B, F->E; since E is 010000, B is first in comparison
                
    assign Y3 = (y == 6'b000010 & ~w) | 
                (y == 6'b001000 & ~w) | 
                (y == 6'b000100 & ~w) | 
                (y == 6'b010000 & ~w) | 
                (y == 6'b100000 & ~w)| 
                (y == 6'b001000 & ~w); // added D->A multiple times to capture the state correctly

endmodule
