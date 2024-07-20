module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S = 2'b00,
		S1 = 2'b01,
		S10 = 2'b10
	} state_t;
	
	state_t current_state, next_state;
	
	// State transition logic
	always @(*) begin
		case (current_state)
			S: begin
				if (x)
					next_state = S1;
				else
					next_state = S;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
			end
			S10: begin
				if (x)
					next_state = S1;
				else
					next_state = S;
			end
			default: next_state = S; // Default case to handle invalid state
		endcase
	end
	
	// State flip-flops with asynchronous reset
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			current_state <= S; // Reset to initial state S
		else
			current_state <= next_state;
		end
	
	// Output logic
	always @(*) begin
		case (current_state)
			S: z = 0;
			S1: z = 0;
			S10: z = x;
			default: z = 0; // Default case to handle invalid state
		endcase
	end

endmodule
