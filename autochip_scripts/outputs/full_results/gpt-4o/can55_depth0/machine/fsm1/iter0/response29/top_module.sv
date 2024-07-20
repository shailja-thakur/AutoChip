module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in) begin
					next_state = STATE_A;
				} else begin
					next_state = STATE_B;
				}
			end
			STATE_B: begin
				if (in) begin
					next_state = STATE_B;
				} else begin
					next_state = STATE_A;
				}
			end
			default: next_state = STATE_B; // default state in case of unexpected scenario
		endcase
	end

	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_B;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			out <= 1'b1; // State B
		end else begin
			case (state)
				STATE_A: out <= 1'b0;
				STATE_B: out <= 1'b1;
				default: out <= 1'b1; // default output in case of unexpected scenario
			endcase
		end
	end
endmodule
