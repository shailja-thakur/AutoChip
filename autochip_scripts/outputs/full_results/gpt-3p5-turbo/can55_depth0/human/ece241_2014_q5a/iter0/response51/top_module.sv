module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define the state enumeration
	typedef enum logic [1:0] {S0, S1} state_type;
	
	// Define the flip-flop and state variables
	reg state_type current_state, next_state;
	reg z_out;
	
	// Define the Moore state machine logic
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			current_state <= S0;
			z_out <= 1'b0;
		end else begin
			current_state <= next_state;
			z_out <= (x == 1'b1) ? 1'b0 : 1'b1;
		end
	end
	
	// Define the next state logic
	always_comb begin
		case (current_state)
			S0: begin
				next_state = (x == 1'b0) ? S0 : S1;
			end
			S1: begin
				next_state = (x == 1'b0) ? S0 : S1;
			end
			default: next_state = S0;
		endcase
	end
	
	// Assign the output
	assign z = z_out;
	
endmodule
