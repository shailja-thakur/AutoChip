module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Declare intermediate signals
    wire y2_wire;
    wire y4_wire;
    
    assign Y2 = y2_wire;
    assign Y4 = y4_wire;
    
    // Logic equations for Y2 and Y4
    assign y2_wire = (y[6] & ~w) | (y[4] & y[5] & w);
    assign y4_wire = (y[4] & ~w) | (y[5] & w);
    
endmodule
