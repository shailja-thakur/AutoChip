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

	// State Definitions
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALLING,
		DIGGING,
		SPLATTERED
	} state_t;

	// Register Variables
	reg state_t current_state;
	reg [4:0] fall_counter;

	// Output Assignments
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state == FALLING);
	assign digging = (current_state == DIGGING);

	// State Transition and Output Logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
			fall_counter <= 0;
		end else begin
			case (current_state)
				WALK_LEFT:
					if (bump_right && !bump_left && ground) begin
						current_state <= WALK_RIGHT;
					end else if ((bump_right && bump_left) || (fall_counter >= 20 && ground)) begin
						current_state <= FALLING;
						fall_counter <= fall_counter + 1;
					end else if (!ground) begin
						current_state <= FALLING;
						fall_counter <= 1;
					end else if (dig && ground) begin
						current_state <= DIGGING;
					end
				WALK_RIGHT:
					if (bump_left && !bump_right && ground) begin
						current_state <= WALK_LEFT;
					end else if ((bump_right && bump_left) || (fall_counter >= 20 && ground)) begin
						current_state <= FALLING;
						fall_counter <= fall_counter + 1;
					end else if (!ground) begin
						current_state <= FALLING;
						fall_counter <= 1;
					end else if (dig && ground) begin
						current_state <= DIGGING;
					end
				FALLING:
					if (ground) begin
						if (fall_counter >= 20) begin
							current_state <= SPLATTERED;
						end else begin
							if (current_state == WALK_LEFT) begin
								current_state <= WALK_LEFT;
							end else if (current_state == WALK_RIGHT) begin
								current_state <= WALK_RIGHT;
							end
						end
						fall_counter <= 0;
					end else begin
						current_state <= FALLING;
						fall_counter <= fall_counter + 1;
					end
				DIGGING:
					if (!ground) begin
						current_state <= FALLING;
						fall_counter <= 1;
					end else if (dig && ground) begin
						current_state <= DIGGING;
					end else begin
						current_state <= WALK_LEFT;
					end
				SPLATTERED:
					current_state <= SPLATTERED;
			endcase
		end
	end

endmodule
