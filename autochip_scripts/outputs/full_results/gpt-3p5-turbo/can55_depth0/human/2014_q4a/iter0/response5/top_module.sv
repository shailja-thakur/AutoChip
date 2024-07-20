module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg Q_next;
	
	always @(posedge clk) begin
		if (L) begin
			Q <= R;
		end else if (E) begin
			Q <= Q_next;
		end
	end
	
	assign Q_next = (E) ? ((Q << 1'b1) | w) : Q;
	
endmodule
