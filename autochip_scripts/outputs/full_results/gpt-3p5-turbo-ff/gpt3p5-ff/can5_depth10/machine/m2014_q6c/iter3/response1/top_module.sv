module top_module (
    input [6:1] y, 
    input w, 
    output Y2, 
    output Y4
    );
    wire [6:1] y_inv;
    assign y_inv = ~y;
    assign Y2 = y[1] & y_inv[6] & w;
    assign Y4 = y[2] & y[3] & y[5] & y[6] & w;
    endmodule
