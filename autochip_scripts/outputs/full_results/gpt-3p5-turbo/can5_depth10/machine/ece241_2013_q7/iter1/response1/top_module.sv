module top_module (
	input wire clk,
	input wire j,
	input wire k,
	output reg Q
);

always @(posedge clk) begin
	if (j && ~k) // Fix: Replace ~Q with ~k
		Q <= j;
	else if (~j && k) // Fix: Replace ~k with ~j
		Q <= 0;
	else if (j && k)
		Q <= ~Q;
end

endmodule
