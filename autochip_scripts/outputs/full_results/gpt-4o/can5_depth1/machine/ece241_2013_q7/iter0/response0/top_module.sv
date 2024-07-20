module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
	if (j == 1'b1 && k == 1'b0) begin
		Q <= 1'b1;
	end else if (j == 1'b0 && k == 1'b1) begin
		Q <= 1'b0;
	end else if (j == 1'b1 && k == 1'b1) begin
		Q <= ~Q;
	end
	// When both j and k are low, Q remains unchanged, no else required for the same
end

endmodule
