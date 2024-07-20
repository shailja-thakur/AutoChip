module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg state, next_state;
reg z;

// State definitions
parameter S_RESET = 2'b00;
parameter S_CONVERTING = 2'b01;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= S_RESET;
		z <= 1'b0;
	end else begin
		state <= next_state;
		z <= z;
	end
end

always @* begin
	case (state)
		S_RESET: begin
			if (areset == 0)
				next_state = S_RESET;
			else
				next_state = S_CONVERTING;
		end
		S_CONVERTING: begin
			next_state = S_CONVERTING;
			if (x == 1'b1)
				z = ~z;
		end
	endcase
end

endmodule
