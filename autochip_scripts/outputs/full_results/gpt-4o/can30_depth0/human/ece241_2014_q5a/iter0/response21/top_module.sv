module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg state, next_state;

	localparam STATE_COPY = 0, STATE_INVERT = 1;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_COPY;
		else
			state <= next_state;
	end

	always @(*) begin
		case (state)
			STATE_COPY: begin
				if (x == 1'b0) begin
					next_state = STATE_COPY;
					z = x;
				end
				else begin
					next_state = STATE_INVERT;
					z = ~x;
				end
			end
			STATE_INVERT: begin
				next_state = STATE_INVERT;
				z = ~x;
			end
			default: begin
				next_state = STATE_COPY;
				z = 1'b0;
			end
		endcase
	end

endmodule
