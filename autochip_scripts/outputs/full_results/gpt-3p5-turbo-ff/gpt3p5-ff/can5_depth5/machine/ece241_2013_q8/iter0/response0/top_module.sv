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
	
	// Define state variables
	reg state, state_next;
	
	// Define state transition logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S; // Reset state to S
		end else begin
			state <= state_next; // Update state
		end
	end
	
	// Define state next logic
	always_comb begin
		case(state)
			S: begin
				if (x == 0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
			end
			
			S1: begin
				if (x == 0) begin
					state_next = S10;
				end else begin
					state_next = S1;
				end
			end
			
			S10: begin
				if (x == 0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
			end
		endcase
	end
	
	// Define output logic
	always_comb begin
		case(state)
			S, S1: begin
				z = 0;
			end
			
			S10: begin
				z = x;
			end
		endcase
	end
	
endmodule
