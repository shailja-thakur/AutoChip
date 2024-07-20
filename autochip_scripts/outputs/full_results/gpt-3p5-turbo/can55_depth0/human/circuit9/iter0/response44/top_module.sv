module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a) begin
		if (q == 7)
			q <= 0;
		else
			q <= q + 1;
	end
	else
		q <= q;
end

endmodule
