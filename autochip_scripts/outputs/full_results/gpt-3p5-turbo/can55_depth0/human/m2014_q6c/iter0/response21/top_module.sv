module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg Y2;
reg Y4;

always @*
begin
	Y2 = (y[1]==1 && !y[2] && !y[4]) || (y[3]==1 && !y[2]) || (y[5]==1 && !y[4]);
	Y4 = (y[2]==1 && !y[1]) || (y[3]==1 && !y[4]) || (y[6]==1 && !y[4]);
end

endmodule
