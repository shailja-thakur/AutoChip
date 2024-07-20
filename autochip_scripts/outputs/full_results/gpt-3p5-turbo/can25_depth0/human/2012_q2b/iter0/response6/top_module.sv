module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @(y, w)
begin
	Y1 = (y[1]) || (y[2]) && (~w) || (y[4] && y[5]);
	Y3 = (y[2] && ~w) || (y[3] && w);
end

endmodule
