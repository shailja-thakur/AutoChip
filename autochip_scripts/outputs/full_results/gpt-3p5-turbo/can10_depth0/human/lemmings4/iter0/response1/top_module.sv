module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_t;
	
	// Define state register
	reg state_t current_state;
	
	// Define next state logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			case (current_state)
				WALK_LEFT: begin
					if (bump_right && !bump_left) begin
						current_state <= WALK_RIGHT;
					end else if (!bump_right && ground && !dig) begin
						current_state <= WALK_LEFT;
					end else if (!ground && !dig) begin
						current_state <= FALL;
					end else if (dig && ground) begin
						current_state <= DIG;
					end end else if (current_state == WALK_RIGHT) begin
					if (bump_left && !bump_right) begin
						current_state <= WALK_LEFT;
					end else if (!bump_left && ground && !dig) begin
						current_state <= WALK_RIGHT;
					end else if (!ground && !dig) begin
						current_state <= FALL;
					end else if (dig && ground) begin
						current_state <= DIG;
					end
				end
				FALL: begin
					if (ground) begin
						current_state <= current_state;
					end else if (!ground && current_state != SPLATTER) begin
						current_state <= FALL;
					end end else if (current_state == DIG) begin
					if (ground) begin
						current_state <= current_state;
					end else if (!ground) begin
						current_state <= FALL;
					end
				end
				SPLATTER: begin
					current_state <= current_state;
				end
			endcase
		end
	end
	
	// Define output logic
	always_comb begin
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			FALL: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			DIG: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
