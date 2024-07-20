module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states
	parameter S0 = 1'b0; // Initial state
	parameter S1 = 1'b1; // After finding the first '1' state

	reg state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			z <= 1'b0;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					next_state = S1;
					z = 1'b1;
				end else begin
					next_state = S0;
					z = 1'b0;
				end
			end
			S1: begin
				next_state = S1;
				z = ~x;
			end
			default: begin
				next_state = S0;
				z = 1'b0;
			end
		endcase
	end

endmodule
