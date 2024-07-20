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
		if (E) begin
			Q_next <= L ? R : Q;
		end else begin
			Q_next <= Q;
		end
	end

	always @(posedge clk) begin
		Q <= Q_next;
	end

	assign Q_next = w;

endmodule
