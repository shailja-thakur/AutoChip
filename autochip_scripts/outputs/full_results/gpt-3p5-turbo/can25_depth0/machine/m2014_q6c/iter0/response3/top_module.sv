module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
    wire y_1;
    wire y_2;
    wire y_3;
    wire y_4;
    wire y_5;
    wire y_6;
    
    assign y_1 = y[1];
    assign y_2 = y[2];
    assign y_3 = y[3];
    assign y_4 = y[4];
    assign y_5 = y[5];
    assign y_6 = y[6];
    
    assign Y2 = y_1 & (~w);
    assign Y4 = y_2 & y_3 & y_5 & y_6 & w;
    
endmodule
