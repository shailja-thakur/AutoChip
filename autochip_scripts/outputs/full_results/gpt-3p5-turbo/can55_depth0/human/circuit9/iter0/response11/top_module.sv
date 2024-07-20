module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always@(posedge clk) 
	begin
		if (a == 0)
			q <= 000;
		else if (q == 111)
			q <= q - 2;
		else
			q <= q + 1;
	end

endmodule
