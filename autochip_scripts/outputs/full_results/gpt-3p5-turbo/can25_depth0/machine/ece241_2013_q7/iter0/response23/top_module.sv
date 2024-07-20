module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

// always block triggers on the rising edge of the clock signal
always @(posedge clk) begin
	if ((j == 1'b1) && (k == 1'b0)) // j=1, k=0 -> set Q to j
		Q <= j;
	else if ((j == 1'b0) && (k == 1'b1)) // j=0, k=1 -> reset Q to 0
		Q <= 1'b0;
	else if ((j == 1'b1) && (k == 1'b1)) // j=1, k=1 -> toggle Q
		Q <= ~Q;
end

endmodule
