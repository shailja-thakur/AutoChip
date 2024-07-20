module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	/* Declare flip-flop */
	reg q;
	
	/* Declare state variable */
	reg state;
	
	always @(posedge clk) begin
		/* Logic for state */
		if (state == 1'b0 && a == 1'b0 && b == 1'b0)
			state <= 1'b0;
		else if (state == 1'b0 && a == 1'b0 && b == 1'b1)
			state <= 1'b1;
		else if (state == 1'b0 && a == 1'b1 && b == 1'b0)
			state <= 1'b1;
		else if (state == 1'b0 && a == 1'b1 && b == 1'b1)
			state <= 1'b0;
		else if (state == 1'b1 && a == 1'b0 && b == 1'b0)
			state <= 1'b0;
		else if (state == 1'b1 && a == 1'b0 && b == 1'b1)
			state <= 1'b0;
		else if (state == 1'b1 && a == 1'b1 && b == 1'b0)
			state <= 1'b0;
		else if (state == 1'b1 && a == 1'b1 && b == 1'b1)
			state <= 1'b1;
			
		/* Logic for output q */
		if (state == 1'b0)
			q <= 1'b0;
		else if (state == 1'b1)
			q <= 1'b1;
	end
	
	/* Assign output signals */
	assign state = state;
	assign q = q;
	
endmodule
