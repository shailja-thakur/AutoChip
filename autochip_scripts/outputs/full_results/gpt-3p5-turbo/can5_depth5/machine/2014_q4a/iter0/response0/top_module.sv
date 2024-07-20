module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (L == 1'b1 && E == 1'b1) begin
		Q <= R;
	end else if (L == 1'b0 && E == 1'b1) begin
		Q <= w;
	end
end

always @(posedge clk) begin
	if (R == 1'b1 && E == 1'b0) begin
		Q <= 1'b0;
	end
end

endmodule
