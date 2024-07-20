module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg mux1_out, mux2_out;

	// Multiplexer 1 for shifting or holding
	always @(*) begin
		if (E) 
			mux1_out = w; // Shift in the new bit
		else
			mux1_out = Q; // Hold the current value
	end

	// Multiplexer 2 for loading or using the mux1 output
	always @(*) begin
		if (L)
			mux2_out = R; // Load the new value
		else
			mux2_out = mux1_out; // Use the output of mux1
	end

	// D Flip-Flop
	always @(posedge clk) begin
		Q <= mux2_out; // Update the state
	end

endmodule
