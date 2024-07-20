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
	
	// Declare state registers
	reg state_reg;
	reg state_next;
	
	// Default initial state
	parameter DEFAULT_STATE = S;
	
	// Define state transitions and output assignments
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state_reg <= DEFAULT_STATE; // Reset to default state
		end else begin
			state_reg <= state_next; // Update state
		end
	end
	
	always_comb begin
		case (state_reg)
			S: begin
				if (x === 0) begin
					state_next = S;
					z = 0;
				end else if (x === 1) begin
					state_next = S1;
					z = 0;
				end
			end
			
			S1: begin
				if (x === 0) begin
					state_next = S10;
					z = 0;
				end else if (x === 1) begin
					state_next = S1;
					z = 0;
				end
			end
			
			S10: begin
				if (x === 0) begin
					state_next = S;
					z = 0;
				end else if (x === 1) begin
					state_next = S1;
					z = x;
				end
			end
			
			default: begin
				state_next = DEFAULT_STATE; // Default state transition
				z = 0; // Default output assignment
			end
		endcase
	end
	
endmodule
