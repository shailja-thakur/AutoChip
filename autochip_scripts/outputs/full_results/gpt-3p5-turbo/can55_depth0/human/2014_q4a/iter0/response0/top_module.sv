module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	// Internal signals
	reg Q_next; // Next value of Q
	reg Q_load; // Load signal for Q
	reg R_load; // Load signal for R
	// Flip-flop for Q
	always @(posedge clk) begin
		if (Q_load) begin
			Q <= R;
		end else begin
			Q <= Q_next;
		end
	end
	
	// Multiplexers
	always @(posedge clk) begin
		Q_next = L ? R : (E ? w : Q);
		Q_load = L;
		R_load = E;
	end
endmodule
