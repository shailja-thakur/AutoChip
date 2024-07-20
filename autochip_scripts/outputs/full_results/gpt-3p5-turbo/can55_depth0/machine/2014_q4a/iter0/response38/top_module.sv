module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (E == 1'b1) begin
		if (L == 1'b1)
			Q <= R;
		else
			Q <= w;
	end
end

always @(negedge clk) begin
	if (R == 1'b1)
		Q <= 1'b0;
end

endmodule
