module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @(*) begin
        // Derive Y2 (next state corresponds to state 'B', 'C', or 'F')
        Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[6] & ~w); 
        
        // Derive Y4 (next state corresponds to state 'D')
        Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);
    end

endmodule
