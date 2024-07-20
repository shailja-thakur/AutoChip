module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg state;
	reg next_state;

	always @(posedge clk) begin
		if(areset)
			state <= 1'b0;
		else
			state <= next_state;
	end

	always @* begin
		if(state == 1'b0) begin
			if(in)
				next_state = 1'b0;
			else
				next_state = 1'b1;
		end else begin
			if(in)
				next_state = 1'b1;
			else
				next_state = 1'b0;
		end
	end
	
	assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
