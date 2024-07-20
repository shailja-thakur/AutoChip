module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (L) begin
		Q <= R;          // Load the value R into the flip-flop
	end else if (E) begin
		Q <= w;          // Shift the value w into the flip-flop
	end
end

endmodule
