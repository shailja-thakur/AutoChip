module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	reg state, next_state;
	
	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= 0;
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case (state)
			0: begin
				if (areset)
					next_state <= 0;
				else
					next_state <= 1;
			end
			1: begin
				if (x)
					next_state <= 2;
				else
					next_state <= 1;
			end
			2: begin
				if (x)
					next_state <= 1;
				else
					next_state <= 2;
			end
			default: next_state <= state;
		endcase
	end
	
	always @(posedge clk) begin
		if (areset)
			z <= 0;
		else begin
			case (state)
				0: z <= x;
				1: z <= ~x + 1;
				2: z <= z;
				default: z <= z;
			endcase
		end
	end
endmodule
