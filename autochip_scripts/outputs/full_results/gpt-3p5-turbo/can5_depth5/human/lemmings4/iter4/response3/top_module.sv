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
	parameter IDLE = 4'b0001;
	parameter WALK_LEFT = 4'b0010;
	parameter WALK_RIGHT = 4'b0100;
	parameter FALLING = 4'b1000;

	// Define counters
	reg [4:0] fall_counter;

	// Initialize outputs
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALLING);
	assign digging = (state == IDLE);

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
					end else if (dig == 1) begin
						state <= IDLE;
						fall_counter <= 0;
					end else if (bump_left && !bump_right) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (!bump_left && bump_right) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left && bump_right) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end
				end
				WALK_LEFT: begin
					if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (bump_left && !bump_right) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (!bump_left && bump_right) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left && bump_right) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end
				end
				WALK_RIGHT: begin
					if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (bump_left && !bump_right) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (!bump_left && bump_right) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left && bump_right) begin
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
							state <= IDLE;
							fall_counter <= 0;
						end
					end else begin
						state <= FALLING;
						fall_counter <= fall_counter + 1;
					end
				end
			endcase
		end
	end
endmodule
