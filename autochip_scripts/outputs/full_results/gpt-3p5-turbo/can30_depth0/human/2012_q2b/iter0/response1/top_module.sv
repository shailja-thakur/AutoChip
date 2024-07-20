module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @(y) begin
	Y1 = y[1];
	Y3 = y[3];
end

endmodule
