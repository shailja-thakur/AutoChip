module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg next;
	always @(posedge clk) begin
		if (L) begin
			Q <= R;
		end else if (E) begin
			Q <= next;
		end
	end
	always @(posedge clk) begin
		next <= R ? 1'b1 : w;
	end
endmodule
