module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    
    // State Encoding:
    // y[1]: A = 000001
    // y[2]: B = 000010
    // y[3]: C = 000100
    // y[4]: D = 001000
    // y[5]: E = 010000
    // y[6]: F = 100000
    
    // Next state logic for Y2 (State B)
    assign Y2 = (~w & y[1]) | (~w & y[2]);
    
    // Next state logic for Y4 (State D)
    assign Y4 = (w & y[2]) | (w & y[3]) | (w & y[4]) | (w & y[5]) | (w & y[6]);

endmodule
