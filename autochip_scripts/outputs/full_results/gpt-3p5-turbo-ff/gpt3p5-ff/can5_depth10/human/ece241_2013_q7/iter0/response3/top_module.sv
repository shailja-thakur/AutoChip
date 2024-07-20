module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
	if (j & k)
		Q <= ~Q;
	else if (j)
		Q <= 1;
	else if (k)
		Q <= 0;
end

endmodule
