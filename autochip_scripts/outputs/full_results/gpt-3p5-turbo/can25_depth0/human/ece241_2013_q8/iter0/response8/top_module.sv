module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define states
	typedef enum logic [1:0] {
		S0,
		S1,
		S2
	} state_t;
	
	// Define current state and next state variables
	reg state_t current_state;
	reg state_t next_state;
	
	// Instantiate a 2-bit shift register to store the previous 2 input values
	reg [1:0] shift_reg;
	
	// Assign default values to current state and next state variables
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			current_state <= S0;
			next_state <= S0;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Assign next state based on current state and input value
	always_comb begin
		case (current_state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S2;
				else
					next_state = S1;
			end
			S2: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
	end
	
	// Output assignment based on current state
	always_comb begin
		case (current_state)
			S2: z = 1'b1;
			default: z = 1'b0;
		endcase
	end
	
	// Shift register updates
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			shift_reg <= 2'b00;
		else
			shift_reg <= {shift_reg[0], x};
	end
endmodule
