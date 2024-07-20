module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	
	reg mux1_out;
	reg mux2_out;

	always @(*) begin
		if (L)
			mux1_out = R;
		else
			mux1_out = Q;
	end

	always @(*) begin
		if (E)
			mux2_out = w;
		else
			mux2_out = mux1_out;
	end

	always @(posedge clk) begin
		Q <= mux2_out;
	end

endmodule
