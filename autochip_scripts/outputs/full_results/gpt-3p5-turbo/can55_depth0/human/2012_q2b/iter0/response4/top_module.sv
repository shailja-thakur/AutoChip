module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always@(y) begin
	if(y[1])
		Y1 <= w;
	else
		Y1 <= ~w;
end

always@(y) begin
	if(y[3])
		Y3 <= w;
	else
		Y3 <= ~w;
end

endmodule
