module top_module (
	input clk, 
	input a,
	output reg [2:0] q
);
	
always @(posedge clk) begin
	if (a == 1) begin
		if (q == 0)
			q <= 4;
		else if (q == 4)
			q <= 4;
		else if (q == 5)
			q <= 6;
		else
			q <= 1;
	end
	else begin
		if (q == 0)
			q <= 0;
		else
			q <= q;
	end
end

endmodule
