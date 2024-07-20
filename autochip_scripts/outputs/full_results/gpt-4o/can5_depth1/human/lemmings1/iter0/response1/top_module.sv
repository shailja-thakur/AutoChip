module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// State encoding
	typedef enum logic [1:0] {
		LEFT  = 2'b01,
		RIGHT = 2'b10
	} state_t;
	
	state_t state, next_state;
	
	// State transition and output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		case(state)
			LEFT: begin
				if (bump_left || bump_right) begin
					next_state = RIGHT;
				end else begin
					next_state = LEFT;
				end
			end
			RIGHT: begin
				if (bump_left || bump_right) begin
					next_state = LEFT;
				end else begin
					next_state = RIGHT;
				end
			end
			default: next_state = LEFT;
		endcase
	end
	
	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1;
			walk_right <= 0;
		end else begin
			case(state)
				LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
				end
				RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
				end
			endcase
		end
	end
endmodule
