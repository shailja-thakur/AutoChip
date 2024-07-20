module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (E == 1'b0) begin
		// Hold Q in its current state
	end
	else begin
		if (L == 1'b1) begin
			Q <= R; // Update Q with value of R
		end
		else if (L == 1'b0) begin
			Q <= w; // Update Q with value of w
		end
	end
	
	if (R == 1'b1) begin
		Q <= 1'b0;
	end
	else if (R == 1'b0 && E == 1'b1) begin
		Q <= Q;
	end
end

endmodule
