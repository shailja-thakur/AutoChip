module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg D;
	reg mux_output;

	always @(posedge clk) begin
		if (E) begin
			D <= w;
		end else if (L) begin
			D <= R;
		end
	end

	always @(posedge clk) begin
		if (E) begin
			mux_output <= D;
		end else if (L) begin
			mux_output <= R;
		end
	end

	always @(posedge clk) begin
		Q <= mux_output;
	end

endmodule
