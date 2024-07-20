module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);
	// Define states
	reg [3:0] state;
	parameter IDLE = 4'b0000;
	parameter WALK_LEFT = 4'b0001;
	parameter WALK_RIGHT = 4'b0010;
	parameter FALLING = 4'b0100;
	parameter DIGGING = 4'b1000;

	// Define counters
	reg [4:0] fall_counter;

	// Initialize outputs
	always @(state) begin
		case (state)
			IDLE: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b0;
			end
			WALK_LEFT: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b0;
			end
			WALK_RIGHT: begin
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = 1'b0;
				digging = 1'b0;
			end
			FALLING: begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b1;
				digging = 1'b0;
			end
			DIGGING: begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b1;
			end
			default: begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b0;
			end
		endcase
	end

	// Define next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_counter <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (dig == 1 && ground == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 0) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (bump_left == 0 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 1) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end
				end
				WALK_LEFT: begin
					if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (dig == 1 && ground == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 0) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (bump_left == 0 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 1) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end
				end
				WALK_RIGHT: begin
					if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (dig == 1 && ground == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 0) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (bump_left == 0 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end
				end
				FALLING: begin
					if (ground == 1) begin
						if (fall_counter >= 20) begin
							state <= IDLE;
							fall_counter <= 0;
						end else begin
							if (state == WALK_LEFT)
								state <= WALK_LEFT;
							else if (state == WALK_RIGHT)
								state <= WALK_RIGHT;
							else
								state <= IDLE;
							fall_counter <= 0;
						end
					end else begin
						state <= FALLING;
						fall_counter <= fall_counter + 1;
					end
				end
				DIGGING: begin
					if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (dig == 0 && ground == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (dig == 1 && ground == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end
				end
			endcase
		end
	end
endmodule
