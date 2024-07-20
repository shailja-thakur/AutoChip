module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (E == 0)  // hold Q in current state
		Q <= Q;
	else if (L == 1)  // update Q with R
		Q <= R;
	else  // update Q with w
		Q <= w;
end

endmodule
