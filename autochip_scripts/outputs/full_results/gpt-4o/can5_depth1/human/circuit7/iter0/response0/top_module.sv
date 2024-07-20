module top_module (
	input clk,
	input a,
	output reg q
);

always @(posedge clk) begin
	if (a)
		q <= ~q;   // Toggle q when a is 1
	else
		q <= q;   // Hold q when a is 0
end

endmodule
