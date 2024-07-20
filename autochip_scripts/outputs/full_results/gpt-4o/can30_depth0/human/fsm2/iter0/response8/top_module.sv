module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State enumeration
	typedef enum reg {OFF, ON} state_t;
	state_t current_state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (current_state)
			OFF: 	if (j) next_state = ON;
					else next_state = OFF;
			ON: 	if (k) next_state = OFF;
					else next_state = ON;
			default: next_state = OFF;
		endcase
	end

	// State register (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset) 
			current_state <= OFF;
		else 
			current_state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 0;
		else 
			out <= (current_state == ON);
	end

endmodule
