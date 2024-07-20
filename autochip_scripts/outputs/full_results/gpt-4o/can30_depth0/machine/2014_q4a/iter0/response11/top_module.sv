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
		Q <= 0; // Reset condition
	end else if (E) begin
		if (L) begin
			Q <= R; // Load condition
		else begin
			Q <= w; // Write condition
		end
	end
end

endmodule
