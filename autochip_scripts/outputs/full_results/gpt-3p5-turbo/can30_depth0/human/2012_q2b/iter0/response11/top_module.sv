module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @* begin
	Y1 = y[4] | y[3] & w;
	Y3 = y[2] | y[4] & w;
end

endmodule
