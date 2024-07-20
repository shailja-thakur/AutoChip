module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk or posedge R) begin
	if (R) begin
		Q <= 1'b0; // Reset Q to 0 when R is high
	end
	else if (E) begin
		if (L) begin
			Q <= R; // Update Q with value of R when L is high
		}
		else begin
			Q <= w; // Update Q with value of w when L is low
		}
		// If E is low, Q holds its current state (no change)
	end
end

endmodule
