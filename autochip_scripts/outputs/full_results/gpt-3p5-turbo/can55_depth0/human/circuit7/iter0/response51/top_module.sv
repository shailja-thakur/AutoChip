module top_module (
	input clk,
	input a, 
	output reg q
);

// Register flip flop
always @(posedge clk) begin
	if (a)
		q <= 1'b0;
	else
		q <= q;
end

endmodule
