module top_module (
	input wire clk,
	input wire j,
	input wire k,
	output reg Q
);

always @(posedge clk) begin
	if (j && ~Q)
		Q <= j;
	else if (~k && Q)
		Q <= 0;
	else if (j && k)
		Q <= ~Q;
end

endmodule
