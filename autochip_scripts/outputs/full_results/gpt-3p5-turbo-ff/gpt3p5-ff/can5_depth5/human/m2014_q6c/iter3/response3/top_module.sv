module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate signals
    wire y2_wire;
    wire y4_wire;
    
    always @* begin
        // Logic equations for Y2 and Y4
        Y2 = (y[4] && ~w) || (y[6] && y[5] && w);
        Y4 = (y[5] && ~w) || (y[4] && w);
    end
    
endmodule
