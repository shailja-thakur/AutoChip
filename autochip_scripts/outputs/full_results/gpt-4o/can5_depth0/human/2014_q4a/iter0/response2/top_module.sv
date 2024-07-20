module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg mux1_out; // Used to store output of first mux

	always @(*) begin
		// First multiplexer
		if (L) 
			mux1_out = R; 
		else 
			mux1_out = Q;
        
		// Second multiplexer
		if (E)
			mux1_out = w;
	end

	always @(posedge clk) begin
		Q <= mux1_out;
	end

endmodule
