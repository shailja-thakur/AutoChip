module top_module(
	input x,
	input y,
	output z);

	always @(x, y) begin
		if(x && y)
			z = 1;
		else
			z = 0;
	end
	
endmodule
