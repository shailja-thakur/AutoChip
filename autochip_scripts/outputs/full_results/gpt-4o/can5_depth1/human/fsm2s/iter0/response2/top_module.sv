module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		OFF = 2'b00,
		ON  = 2'b01
	} state_t;
	
	state_t state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		// Default to hold state
		next_state = state;
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
			end
			ON: begin
				if (k)
					next_state = OFF;
			end
		endcase
	end

	// State register (sequential)
	always @(posedge clk) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic (Moore machine: depends only on the state)
	always @(posedge clk) begin
		if (reset)
			out <= 0;
		else begin
			case (state)
				OFF: out <= 0;
				ON: out <= 1;
			endcase
		end
	end

endmodule
