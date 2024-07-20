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
        // Default values
        Y1 = 0;
        Y3 = 0;
        
        // Compute Y1
        if (y == B)
            Y1 = (w == 0) ? 1 : 0;
        
        // Compute Y3
        if (y == B || y == C || y == E || y == F) 
            Y3 = (w == 0) ? 1 : 0;
    end

endmodule
