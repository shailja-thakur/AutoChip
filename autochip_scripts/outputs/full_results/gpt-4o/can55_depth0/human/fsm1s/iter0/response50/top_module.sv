module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always_comb begin
		case (state)
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
			
			default: begin
				next_state = STATE_B;
			end
		endcase
	end

	// State register with synchronous reset
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= STATE_B;
		end else begin
			state <= next_state;
		end
		out <= (state == STATE_B) ? 1 : 0;
	end

endmodule
