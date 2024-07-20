module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states using an enumerated type
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_type;

	// Declare state registers
	reg state_reg, state_next;

	// Define state transitions and outputs
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state_reg <= S;
			z <= 0;
		end else begin
			state_reg <= state_next;
			case (state_reg)
				S: begin
					if (x == 1'b0)
						state_next <= S;
					else
						state_next <= S1;
					z <= 0;
				end
				S1: begin
					if (x == 1'b0)
						state_next <= S10;
					else
						state_next <= S1;
					z <= 0;
				end
				S10: begin
					if (x == 1'b0)
						state_next <= S;
					else
						state_next <= S1;
					z <= x;
				end
				default: state_next <= S; // Reset state to S if an unknown state is encountered
			endcase
		end
	end

endmodule
