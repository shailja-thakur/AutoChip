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

	// Define state encoding
	typedef enum logic [1:0] {
		ST_WALK_LEFT,
		ST_WALK_RIGHT,
		ST_FALL,
		ST_DIG,
		ST_SPLATTER
	} state_t;

	// Define signals
	reg [1:0] state;
	reg [4:0] fall_counter;

	// Define outputs
	assign walk_left = (state == ST_WALK_LEFT) ? 1 : 0;
	assign walk_right = (state == ST_WALK_RIGHT) ? 1 : 0;
	assign aaah = (state == ST_FALL || state == ST_SPLATTER) ? 1 : 0;
	assign digging = (state == ST_DIG) ? 1 : 0;

	// Define next state and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= ST_WALK_LEFT;
			fall_counter <= 0;
		end else begin
			case (state)
				ST_WALK_LEFT:
					begin
						if (bump_right && !bump_left) begin
							state <= ST_WALK_RIGHT;
						end else if (!ground) begin
							state <= ST_FALL;
						end else if (dig) begin
							state <= ST_DIG;
						end
					end
				ST_WALK_RIGHT:
					begin
						if (bump_left && !bump_right) begin
							state <= ST_WALK_LEFT;
						end else if (!ground) begin
							state <= ST_FALL;
						end else if (dig) begin
							state <= ST_DIG;
						end
					end
				ST_FALL:
					begin
						if (ground) begin
							if (fall_counter > 20) begin
								state <= ST_SPLATTER;
							end else begin
								state <= (state == ST_WALK_LEFT) ? ST_WALK_LEFT : ST_WALK_RIGHT;
							end
							fall_counter <= 0;
						end else begin
							fall_counter <= fall_counter + 1;
						end
					end
				ST_DIG:
					begin
						if (!ground) begin
							state <= ST_FALL;
						end else if (!dig) begin
							state <= (state == ST_WALK_LEFT) ? ST_WALK_LEFT : ST_WALK_RIGHT;
						end
					end
				ST_SPLATTER:
					begin
						state <= ST_SPLATTER;
					end
				default:
					begin
						state <= ST_WALK_LEFT;
						fall_counter <= 0;
					end
			endcase
		end
	end

endmodule
