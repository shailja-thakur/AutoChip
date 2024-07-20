module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    wire y1 = y[1];
    wire y2 = ~w & y1;
    
    wire y3 = y[2] & y[3] & y[5] & y[6];
    wire Y4 = w & y3;
    
    assign Y2 = y2;
    assign Y4 = Y4;
    
endmodule
