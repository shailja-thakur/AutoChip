module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    
    wire Y2_eq;
    wire Y4_eq;
    
    assign Y2 = Y2_eq;
    assign Y4 = Y4_eq;
    
    // Next state logic equations
    assign Y2_eq = (~y[6] & ~y[5] & ~w) | (y[6] & ~y[5] & w) | (y[6] & y[5] & ~y[3] & ~w);
    assign Y4_eq = (~y[6] & ~y[5] & ~y[2] & ~w) | (~y[6] & ~y[5] & y[2] & ~w) | (y[6] & y[5] & ~y[3] & ~w) | (y[6] & y[5] & y[3] & w);
    
endmodule
