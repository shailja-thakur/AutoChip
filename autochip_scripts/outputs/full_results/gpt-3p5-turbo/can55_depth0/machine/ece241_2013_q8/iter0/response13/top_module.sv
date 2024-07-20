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
	
	// Declare state variables
	reg state, state_next;
	
	// Assign initial state
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;
		end else begin
			state <= state_next;
		end
	end
	
	// Assign next state based on input and current state
	always @* begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
			end
			S1: begin
				if (x == 1'b0) begin
					state_next = S10;
				end else begin
					state_next = S1;
				end
			end
			S10: begin
				if (x == 1'b0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
			end
			default: begin
				state_next = S; // Default to S state
			end
		endcase
	end
	
	// Assign output based on current state
	always @* begin
		case (state)
			S, S1: begin
				z = 1'b0;
			end
			S10: begin
				z = x;
			end
			default: begin
				z = 1'b0; // Default to 0 output
			end
		endcase
	end
	
endmodule
