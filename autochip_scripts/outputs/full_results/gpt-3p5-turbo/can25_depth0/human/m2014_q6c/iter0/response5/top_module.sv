module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire a_n, b_n, c_n, d_n, e_n, f_n;
    wire y_2, y_4;
    
    assign a_n = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
    assign b_n = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
    assign c_n = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
    assign d_n = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
    assign e_n = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
    assign f_n = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
    
    assign y_2 = y[6] & ~y[5] & ~y[4] & ~y[3] & y[2] & ~y[1];
    assign y_4 = ~y[6] & ~y[5] & ~y[4] & y[3] & ~y[2] & ~y[1];
    
    assign Y2 = y_2;
    assign Y4 = y_4;

endmodule
