module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	// Shift register flip-flop
	reg D;
	
	// MUX for selecting input
	reg S;
	
	// Output multiplexer
	assign Q = S ? D : w;
	
	always @(posedge clk) begin
		if (E) begin
			if (L) begin
				D <= R;
			end else begin
				D <= Q;
			end
		end
	end
	
	always @(posedge clk) begin
		S <= E;
	end
	
endmodule
