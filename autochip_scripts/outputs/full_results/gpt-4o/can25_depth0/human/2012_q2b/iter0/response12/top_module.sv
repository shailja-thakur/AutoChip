module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    always @(*) begin
        // Y1 is the input to the state flip-flop y[1] (B state)
        // Transitions to 'B' happen from state 'A' with input 'w' being 1
        Y1 = y[0] & w;

        // Y3 is the input to the state flip-flop y[3] (D state)
        // Transitions to 'D' happen from state 'B' with input 'w' being 0, 
        // from state 'C' with input 'w' being 0, 
        // from state 'D' with input 'w' being 0, 
        // from state 'E' with input 'w' being 0, 
        // from state 'F' with input 'w' being 0
        Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);
    end

endmodule
