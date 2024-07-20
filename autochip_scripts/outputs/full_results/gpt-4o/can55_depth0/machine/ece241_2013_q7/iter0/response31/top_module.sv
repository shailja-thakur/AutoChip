module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
	if (j == 1'b0 && k == 1'b0) // No change
		Q <= Q;
	else if (j == 1'b0 && k == 1'b1) // Reset
		Q <= 1'b0;
	else if (j == 1'b1 && k == 1'b0) // Set
		Q <= 1'b1;
	else if (j == 1'b1 && k == 1'b1) // Toggle
		Q <= ~Q;
end

endmodule
