module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State definitions
	typedef enum logic [0:0] {
		OFF = 1'b0,
		ON = 1'b1
	} state_t;

	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			OFF: 
				if (j == 1'b1) 
					next_state = ON;
				else
					next_state = OFF;
			ON: 
				if (k == 1'b1)
					next_state = OFF;
				else 
					next_state = ON;
			default:
				next_state = OFF;
		endcase
	end
	
	// Synchronous state update logic
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= OFF;
		else 
			state <= next_state;
	end
	
	// Output logic based on state
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 1'b0;
		else
			case (state)
				OFF: out <= 1'b0;
				ON: out <= 1'b1;
			endcase
	end
endmodule
