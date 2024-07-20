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
		// Hold Q in its current state
	end else begin
		if (L == 1) begin
			// Update Q with the value of R
		end else begin
			// Update Q with the value of w
		end
	end
	
	if (R == 1) begin
		// Force Q to a low state
	end
end

assign Q = ????;
endmodule
