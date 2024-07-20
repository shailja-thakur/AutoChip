module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;

	reg [1:0] state;

	// Define state register and next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
					end else if (bump_left || (ground == 0 && !bump_right)) begin
						state <= FALL;
					end
				end
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
					end else if (bump_right || (ground == 0 && !bump_left)) begin
						state <= FALL;
					end
				end
				FALL: begin
					if (ground) begin
						if (state == WALK_LEFT) begin
							state <= WALK_LEFT;
						end else begin
							state <= WALK_RIGHT;
						end
					end
				end
			endcase
		end
	end

	// Define output logic
	always @(state or ground) begin
		case (state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			FALL: begin
				walk_left = 0;
				walk_right = 0;
				if (!ground) begin
					aaah = 1;
				end
			end
		endcase
	end

endmodule
