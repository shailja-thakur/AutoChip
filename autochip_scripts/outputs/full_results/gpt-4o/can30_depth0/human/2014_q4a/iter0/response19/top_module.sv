module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	wire mux1_out, mux2_out;

	// First multiplexer: if L is high, load R, else pass Q
	assign mux1_out = (L) ? R : Q;

	// Second multiplexer: if E is high, load w, else pass mux1_out
	assign mux2_out = (E) ? w : mux1_out;

	// D Flip-Flop
	always @(posedge clk) begin
		Q <= mux2_out;
	end

endmodule
