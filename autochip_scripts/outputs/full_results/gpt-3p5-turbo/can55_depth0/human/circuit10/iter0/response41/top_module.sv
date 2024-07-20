module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg state, q;
	  
	always @(posedge clk)
	begin
		state <= a & b;
	end
	
	always @(posedge clk)
	begin
		if (state)
			q <= 1'b1;
		else
			q <= 1'b0;
	end

endmodule
