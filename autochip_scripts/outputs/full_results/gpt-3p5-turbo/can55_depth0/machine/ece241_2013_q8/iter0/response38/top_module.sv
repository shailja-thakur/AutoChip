module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [3:0] {
		S,
		S1,
		S10
	} state_t;

	// Define state register and next state variable
	reg [3:0] state_reg, state_next;

	// Define combinational logic to calculate next state
	always_comb begin
		case (state_reg)
			S: begin
				case (x)
					1: state_next = S1;
					0: state_next = S;
					default: state_next = S; // Handle unknown input
				endcase
			end
			S1: begin
				case (x)
					1: state_next = S1;
					0: state_next = S10;
					default: state_next = S1; // Handle unknown input
				endcase
			end
			S10: begin
				case (x)
					1: state_next = S1;
					0: state_next = S;
					default: state_next = S10; // Handle unknown input
				endcase
			end
			default: state_next = S; // Handle unknown state
		endcase
	end

	// Define sequential logic to update state register
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state_reg <= S; // Reset state to S
		else
			state_reg <= state_next; // Update state with next state
	end

	// Define output logic
	always_comb begin
		case (state_reg)
			S, S1: z = 0;
			S10: z = x;
			default: z = 0; // Handle unknown state
		endcase
	end

endmodule
