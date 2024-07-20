module top_module(
	input x,
	input y,
	output z);
	
	always @(*) begin
		if (x == 1 && y == 1)
			z = 1;
		else
			z = 0;
	end
	
endmodule
