module top_module (
	input wire clk,
	input wire areset,
	input wire bump_left,
	input wire bump_right,
	input wire ground,
	input wire dig,
	output wire walk_left,
	output wire walk_right,
	output wire aaah,
	output wire digging
);
	// Define states
	reg [5:0] state;
	parameter IDLE = 6'b000001;
	parameter WALK_LEFT = 6'b000010;
	parameter WALK_RIGHT = 6'b000100;
	parameter FALLING = 6'b001000;
	parameter DIGGING = 6'b010000;
	parameter SPLATTER = 6'b100000;

	// Define counters
	reg [5:0] fall_counter;

	// Initialize outputs
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALLING);
	assign digging = (state == DIGGING);

	// Define next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_counter <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (ground == 1 && bump_left == 0 && bump_right == 0) begin
						state <= IDLE;
						fall_counter <= 0;
					end else if (ground == 1 && dig == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (ground == 0) begin
						state <= FALLING;
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
					if (ground == 1 && bump_left == 1 && bump_right == 0) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (ground == 1 && dig == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 1) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (bump_left == 0 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (dig == 1 && ground == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end
				end
				WALK_RIGHT: begin
					if (ground == 1 && bump_left == 0 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (ground == 1 && dig == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 1) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (bump_left == 1 && bump_right == 0) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
					end else if (dig == 1 && ground == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end
				end
				FALLING: begin
					if (ground == 1) begin
						if (fall_counter >= 20) begin
							state <= SPLATTER;
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
				DIGGING: begin
					if (ground == 1 && dig == 0) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
					end else if (ground == 0) begin
						state <= FALLING;
						fall_counter <= 0;
					end else if (ground == 1 && dig == 1) begin
						state <= DIGGING;
						fall_counter <= 0;
					end else if (bump_left == 1 || bump_right == 1) begin
						state <= IDLE;
						fall_counter <= 0;
					end
				end
				SPLATTER: begin
					state <= SPLATTER;
					fall_counter <= 0;
				end
			endcase
		end
	end
endmodule
