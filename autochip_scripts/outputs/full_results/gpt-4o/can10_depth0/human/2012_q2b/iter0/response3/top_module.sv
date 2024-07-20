module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    always @(*) begin
        // Currently in state A (y = 000001), going to B if w=1
        // y[0] = 1, y[1] = 0, w=1 -> Y1 = 1;
        if (y[0] && w)
            Y1 = 1; 
        else 
            Y1 = 0;

        // Currently in state C (y = 000100), going to D if w=0
        // y[2] = 1, w=0 -> Y3 = 1;
        if (y[2] && ~w)
            Y3 = 1; 
        else if (y[1] && ~w)
            // Currently in state B (y = 000010), going to D if w=0
            // y[1] = 1, w=0 -> Y3 = 1;
            Y3 = 1;
        else
            Y3 = 0; 
    end

endmodule
