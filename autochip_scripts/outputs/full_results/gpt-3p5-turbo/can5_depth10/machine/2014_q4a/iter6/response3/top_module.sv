module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk or negedge E) begin
		if (!E) begin
			Q <= Q; // Hold current state
		end
		else if (L) begin
			Q <= R; // Update with R value
		end
		else begin
			Q <= w; // Update with w value
		end
	end

endmodule
