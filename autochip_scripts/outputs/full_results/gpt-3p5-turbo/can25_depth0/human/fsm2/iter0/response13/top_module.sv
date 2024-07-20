module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg state, next_state;

parameter OFF = 0;
parameter ON = 1;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= OFF;
	else
		state <= next_state;
end

always @(state, j, k) begin
	case (state)
		OFF: begin
			if (j)
				next_state = ON;
			else
				next_state = OFF;
		end
		
		ON: begin
			if (k)
				next_state = OFF;
			else
				next_state = ON;
		end
	endcase
end

always @(state) begin
	case (state)
		OFF: begin
			out = 0;
		end
		
		ON: begin
			out = 1;
		end
	endcase
end

endmodule
