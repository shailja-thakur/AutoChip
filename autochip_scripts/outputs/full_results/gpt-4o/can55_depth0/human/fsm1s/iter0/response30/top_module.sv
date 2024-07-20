module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State encoding 
	typedef enum logic [1:0] {
		STATE_B = 2'b01,
		STATE_A = 2'b10
	} state_t; 
	
	state_t current_state, next_state;

	// State transition logic
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= STATE_B;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (current_state)
			STATE_B: begin
				if (in) begin
					next_state = STATE_B;
				end else begin
					next_state = STATE_A;
				end
			end
			STATE_A: begin
				if (in) begin
					next_state = STATE_A;
				end else begin
					next_state = STATE_B;
				end
			end
			default: next_state = STATE_B;
		endcase
	end

	// Output logic
	assign out = (current_state == STATE_B);

endmodule
