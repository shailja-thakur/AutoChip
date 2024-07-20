module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (E == 0) begin
		Q <= Q;
	end else if (L == 1) begin
		Q <= R;
	end else begin
		Q <= w;
	end
end

endmodule
