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
		Q <= 1'b0; // Reset Q to 0 when R is high
	end else if (E) begin
		if (L) begin
			Q <= R; // Update Q with R when L is high
		} else begin
			Q <= w; // Update Q with w when L is low
		}
	end
	// If E is low, Q retains its current value
end

endmodule
