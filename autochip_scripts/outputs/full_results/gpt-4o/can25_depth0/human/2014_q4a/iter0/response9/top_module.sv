module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg mux1_out, mux2_out;

	// Multiplexer that selects between the shift input (w) and the current value of Q based on E
	always @(*) begin
		if (E)
			mux1_out = w;
		else
			mux1_out = Q;
	end

	// Multiplexer that selects between the output of the previous mux and R based on L
	always @(*) begin
		if (L)
			mux2_out = R;
		else
			mux2_out = mux1_out;
		end
	
	// Flip-Flop to store the final value to Q
	always @(posedge clk) begin
		Q <= mux2_out;
	end

endmodule
