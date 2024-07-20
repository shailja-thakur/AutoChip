module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define states
	typedef enum logic [1:0] {
		S_IDLE,
		S_CONVERT
	} state_t;
	
	// Define state register
    reg state_t current_state;

	// Define output register
	reg z_reg;

	always_ff @(posedge clk, negedge areset) begin
		if (!areset) begin
			// Reset the state and output register
			current_state <= S_IDLE;
			z_reg <= 1'b0;
		end else begin
			case (current_state)
				S_IDLE: begin
					if (x == 1'b1) begin
						// Start conversion if input is 1
						z_reg <= ~x;
						current_state <= S_CONVERT;
					end
				end
				
				S_CONVERT: begin
					// Continue conversion
					if (x == 1'b0 && current_state == S_CONVERT) begin
						z_reg <= ~x;
						current_state <= S_CONVERT;
					end else begin
						// Stop conversion if input is 1
						z_reg <= ~x;
						current_state <= S_IDLE;
					end
				end
			endcase
		end
	end

	assign z = z_reg;

endmodule
