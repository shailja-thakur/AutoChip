module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);
    // One-hot encoded states
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    always @(*) begin
        // Default assignments
        Y1 = 0;
        Y3 = 0;
        
        // Determine Y1 (state B)
        if (y == A && w == 1)
            Y1 = 1;
        else if (y == B && w == 1)
            Y1 = 0;
        else if (y == C && w == 1)
            Y1 = 0;
        else if (y == D && w == 0)
            Y1 = 0;
        else if (y == E && w == 0)
            Y1 = 0;
        else if (y == F && w == 1)
            Y1 = 0;

        // Determine Y3 (state D)
        if (y == B && w == 0)
            Y3 = 1;
        else if (y == C && w == 0)
            Y3 = 1;
        else if (y == D && w == 0)
            Y3 = 1;
        else if (y == E && w == 0)
            Y3 = 1;
        else if (y == F && w == 0)
            Y3 = 1;
    end
endmodule
