module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// state definition
	typedef enum logic [3:0] {
		S,
		S1,
		S10
	} state_type;
	
	// state and next state variables
	reg state, next_state;
	
	// default values
	initial begin
		state = S;
		next_state = S;
	end
	
	// state transition and output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;
			next_state <= S;
		end
		else begin
			state <= next_state;
			case(state)
				S: begin
					if (x == 1'b1)
						next_state <= S1;
					else
						next_state <= S;
				end
				
				S1: begin
					if (x == 1'b1)
						next_state <= S1;
					else
						next_state <= S10;
				end
				
				S10: begin
					if (x == 1'b1)
						next_state <= S1;
					else
						next_state <= S;
				end
			endcase
		end
	end
	
	// output assignment
	always @(state) begin
		case(state)
			S, S1: z <= 1'b0;
			S10: z <= x;
		endcase
	end

endmodule
