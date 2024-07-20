module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define the states for the Moore state machine
	typedef enum logic [1:0] {IDLE, CONVERT} state;

	// Define the outputs for the Moore state machine
	reg signed [31:0] z_reg;
	assign z = z_reg;

	// Define the state register and next state variables
	reg state current_state;
	reg state next_state;

	// Define internal signals
	reg x_reg;
	reg update_z;

	// Reset logic
	always @(posedge clk)
	begin
		if (areset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// State transition logic
	always @(*)
	begin
		case (current_state)
			IDLE:
				if (!areset && x)
					next_state = CONVERT;
				else
					next_state = IDLE;
			CONVERT:
				if (!areset && !x)
					next_state = IDLE;
				else
					next_state = CONVERT;
		endcase
	end

	// Output logic
	always @(current_state, x_reg)
	begin
		case (current_state)
			IDLE:
				update_z = 0;
			CONVERT:
				if (x_reg)
					update_z = 1;
				else
					update_z = 0;
		endcase
	end

	// Combinational logic for z_reg
	always @(posedge clk, areset)
	begin
		if (areset)
			z_reg <= 0;
		else if (update_z)
			z_reg <= ~x_reg + 1;
	end

	// Register x on every clock cycle
	always @(posedge clk, areset)
	begin
		if (areset)
			x_reg <= 0;
		else
			x_reg <= x;
	end

endmodule
