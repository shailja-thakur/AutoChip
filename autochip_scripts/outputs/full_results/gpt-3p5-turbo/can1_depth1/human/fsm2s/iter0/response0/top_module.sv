module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// states
	enum {OFF, ON} state;
	reg [1:0] next_state;
	
	// always block to determine next_state based on current state and inputs
	always @(posedge clk or posedge reset) begin
		if (reset)
			next_state <= OFF;
		else begin
			case (state)
				OFF: begin
					if (j)
						next_state <= ON;
					else
						next_state <= OFF;
				end
				ON: begin
					if (k)
						next_state <= OFF;
					else
						next_state <= ON;
				end
				default: next_state <= OFF;
			endcase
		end
	end
	
	// always block to update current state and output based on next_state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
		case (state)
			OFF: out <= 0;
			ON: out <= 1;
			default: out <= 0;
		endcase
	end

endmodule
