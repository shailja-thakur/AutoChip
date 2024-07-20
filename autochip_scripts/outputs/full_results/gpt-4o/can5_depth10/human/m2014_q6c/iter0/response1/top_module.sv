module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // Next state logic for Y2 (State B)
    assign Y2 = (~w & y[1]); // B <- A when w == 0

    // Next state logic for Y4 (State D)
    assign Y4 = ( w & y[2]) | ( w & y[3]) | ( w & y[6]) | 
                (~w & y[4]) | (~w & y[5]); // D <- B, C, C, F, E

endmodule
