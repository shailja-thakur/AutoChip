module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_t;
	
	// Define state and next state variables
	reg state_t state, next_state;
	
	// Define state transition and output logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end

	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b0)
					next_state = S;
				else
					next_state = S1;
				z = 1'b0;
			end
			
			S1: begin
				if (x == 1'b0)
					next_state = S10;
				else
					next_state = S1;
				z = 1'b0;
			end
			
			S10: begin
				if (x == 1'b0)
					next_state = S;
				else
					next_state = S1;
				z = x;
			end
		endcase
	end

endmodule
