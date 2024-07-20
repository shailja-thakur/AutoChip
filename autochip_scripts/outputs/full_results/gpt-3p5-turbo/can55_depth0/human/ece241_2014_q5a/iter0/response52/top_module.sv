module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// State Enum
	typedef enum logic [1:0] {
		IDLE,
		CONVERT
	} state_t;

	// State Registers
	reg state_t current_state;
	reg state_t next_state;

	// Output Register
	reg z_reg;
	wire z;
	assign z = z_reg;

	// Combinational Logic
	always_comb begin
		case (current_state)
			IDLE: begin
				z_reg = 0;
				if (!areset)
					next_state = CONVERT;
				else
					next_state = IDLE;
			end

			CONVERT: begin
				z_reg = ~x + 1;
				if (areset)
					next_state = IDLE;
				else
					next_state = CONVERT;
			end
		endcase
	end

	// Sequential Logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

endmodule
