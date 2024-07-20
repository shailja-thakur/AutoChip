module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (R) begin
		Q <= 1'b0;                   // Reset the register to 0 when R is high.
	end else if (E) begin
		if (L) begin
			Q <= R;                // Load the value of R when L is high.
		else
			Q <= w;                // Load the value of w when L is low.
		end
	end
	// If E is low, Q retains its value.
end

endmodule
