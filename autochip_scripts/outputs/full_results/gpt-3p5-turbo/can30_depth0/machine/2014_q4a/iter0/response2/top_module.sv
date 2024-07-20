module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (L == 1'b1) begin
			Q <= R;
		end else begin
			Q <= E ? w : Q;
		end
	end

endmodule
