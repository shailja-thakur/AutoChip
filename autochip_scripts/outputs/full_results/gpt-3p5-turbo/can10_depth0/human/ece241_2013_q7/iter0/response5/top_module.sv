module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

reg Qold;

always @(posedge clk) begin
	if (j & ~k)
		Q <= ~Qold;
	else if (~j & k)
		Q <= Qold;
end

endmodule
