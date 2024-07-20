module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire Y2_wire, Y4_wire;
    
    assign Y2_wire = ~w & y[1];
    assign Y4_wire = y[2] & y[3] & y[5] & y[6] & w;
    
    assign Y2 = Y2_wire;
    assign Y4 = Y4_wire;

endmodule
