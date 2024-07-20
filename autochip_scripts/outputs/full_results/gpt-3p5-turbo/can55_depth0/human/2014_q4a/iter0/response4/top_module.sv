module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D; // Data input to flip-flop
reg enable; // Enable input to multiplexer

always @(posedge clk) begin
	if (L)
		D <= R;
	else if (E)
		D <= w;
end

always @(posedge clk) begin
	if (L)
		enable <= 1;
	else if (E)
		enable <= 0;
end

always @(posedge clk) begin
	if (L)
		Q <= D;
	else if (E)
		Q <= enable ? D : Q;
end

endmodule
