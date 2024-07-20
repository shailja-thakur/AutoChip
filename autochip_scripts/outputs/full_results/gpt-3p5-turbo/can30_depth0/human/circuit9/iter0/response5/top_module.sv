module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1'b1)
		q <= q + 3'b1;
	else if (q > 0)
		q <= q - 3'b1;
end

endmodule
