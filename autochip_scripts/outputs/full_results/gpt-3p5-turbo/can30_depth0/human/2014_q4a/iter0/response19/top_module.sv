module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg Q_next;
reg Q_reg;

always @(posedge clk) begin
	if (E) begin
		Q_next = (L) ? R : ((w) ? 1'b1 : Q_reg);
		Q_reg <= Q_next;
	end
end

assign Q = Q_reg;

endmodule
