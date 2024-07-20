module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define states
	typedef enum logic[1:0] {
		OFF,
		ON
	} state;

	// Declare registers
	reg state current_state, next_state;
	reg out_reg;

	// Default initial values
	assign current_state = OFF;
	assign out = out_reg;

	// State transition and output logic
	always_ff @(posedge clk, posedge areset)
	begin
		if (areset)
		begin
			current_state <= OFF;
			out_reg <= 0;
		end
		else
		begin
			current_state <= next_state;
			case (current_state)
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

			case (current_state)
				OFF: out_reg <= 0;
				ON: out_reg <= 1;
			endcase
		end
	end

endmodule
