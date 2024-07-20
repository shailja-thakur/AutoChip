module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	 reg state;
	 
	 always @(posedge clk, posedge areset)
	 begin
		if (areset)
			state <= 1'b0;
		else
		begin
			if (state == 1'b0) // State A
			begin
				if (in)
					state <= 1'b0; // Stay in A if 'in' is high
				else
					state <= 1'b1; // Transition to B if 'in' is low
			end
			else // State B
			begin
				if (in)
					state <= 1'b1; // Stay in B if 'in' is high
				else
					state <= 1'b0; // Transition to A if 'in' is low
			end
		end
	 end

	 assign out = ~state;

endmodule
