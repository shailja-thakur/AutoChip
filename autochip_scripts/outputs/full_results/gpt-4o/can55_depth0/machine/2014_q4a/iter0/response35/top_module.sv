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
			Q <= 0;  // Reset the register to 0 when reset signal is high
		end else if (E) begin
			if (L) begin
				Q <= R;  // Update Q with the value of R when L is high
			} else begin
				Q <= w;  // Update Q with the value of w when L is low
			}
		end
		// If E is low, retain the current value of Q
	end
endmodule
