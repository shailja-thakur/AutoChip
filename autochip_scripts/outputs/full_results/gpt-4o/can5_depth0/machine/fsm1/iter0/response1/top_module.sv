module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A = 1'b0, B = 1'b1} state_t;
	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			
			default: next_state = B; // Default state if needed
		endcase
	end 

	// State register logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= B;
		else
			current_state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (current_state == B)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule
