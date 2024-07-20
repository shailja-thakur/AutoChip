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
		// Output Q is held in its current state
		Q <= Q;
	end else if (L == 1) begin
		// Output Q is updated with the value of R
		Q <= R;
	end else begin
		// Output Q is updated with the value of w
		Q <= w;
	end
end

endmodule
