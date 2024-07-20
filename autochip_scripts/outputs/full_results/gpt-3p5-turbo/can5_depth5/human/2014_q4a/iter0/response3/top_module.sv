module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D, D_next;

always @(posedge clk) begin
	if (L) begin
		D_next <= R;
	end else if (E) begin
		D_next <= w;
	end
end

always @(posedge clk) begin
	D <= D_next;
end

assign Q = D;

endmodule
