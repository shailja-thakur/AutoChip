module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
	if (j == 0 && k == 0) 
		Q <= Q;         // 0 0 Qold
	else if (j == 0 && k == 1)
		Q <= 0;         // 0 1 0
	else if (j == 1 && k == 0)
		Q <= 1;         // 1 0 1
	else if (j == 1 && k == 1)
		Q <= ~Q;        // 1 1 ~Qold
end

endmodule
