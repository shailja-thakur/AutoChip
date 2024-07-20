module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire [6:1] y_temp;
    assign y_temp = y;
  
    assign Y2 = y[1] & ~w;
    assign Y4 = y_temp[2] & y_temp[3] & y_temp[5] & y_temp[6] & w;
  
endmodule
