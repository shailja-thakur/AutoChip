module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
	if (j == 1'b0 && k == 1'b0)
		Q <= Q; // No change
	else if (j == 1'b0 && k == 1'b1)
		Q <= 1'b0; // Reset
	else if (j == 1'b1 && k == 1'b0)
		Q <= 1'b1; // Set
	else
		Q <= ~Q; // Toggle
end

endmodule
