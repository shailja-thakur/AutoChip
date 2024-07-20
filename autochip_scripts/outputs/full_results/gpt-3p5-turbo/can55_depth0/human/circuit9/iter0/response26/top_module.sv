module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk)
begin
	if (a == 1'b0)
		q <= 3'b0;
	else if (q == 3'b0)
		q <= 3'b1;
	else
		q <= q + 3'b1;
end

endmodule
