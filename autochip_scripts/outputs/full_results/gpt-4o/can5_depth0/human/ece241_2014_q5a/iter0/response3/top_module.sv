module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg state, next_state;

	parameter STATE_0 = 1'b0; // Initial state
	parameter STATE_1 = 1'b1; // Output inverted

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_0;
			z <= 1'b0;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			STATE_0: begin
				if (x == 1'b1) begin
					next_state = STATE_1;
					z = 1'b1;
				end else begin
					next_state = STATE_0;
					z = 1'b0;
				end
			end
			STATE_1: begin
				z = ~x;
				next_state = STATE_1;
			end
			default: begin
				next_state = STATE_0;
				z = 1'b0;
			end
		endcase
	end

endmodule
