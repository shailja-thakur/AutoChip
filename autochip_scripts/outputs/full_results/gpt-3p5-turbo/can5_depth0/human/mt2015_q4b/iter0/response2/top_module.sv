module top_module(
	input x,
	input y,
	output z);

	// define internal signal
	wire [1:0] state;

	// assign z based on state and inputs
	assign z = (state == 2'b10) || (state == 2'b11);

	// assign next state based on current state and inputs
	always @(state, x, y) begin
		case (state)
			2'b00: begin
				if (x && !y)
					state <= 2'b10;
				else if (x && y)
					state <= 2'b11;
				else
					state <= state;
			end
			2'b10: begin
				if (x && y)
					state <= 2'b11;
				else if (!x && y)
					state <= 2'b00;
				else
					state <= state;
			end
			2'b11: begin
				if (x)
					state <= 2'b11;
				else if (!y)
					state <= 2'b00;
				else
					state <= state;
			end
			default: begin
				state <= 2'b00;
			end
		endcase
	end
endmodule
