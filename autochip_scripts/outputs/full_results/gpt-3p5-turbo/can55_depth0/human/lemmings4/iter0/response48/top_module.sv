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
	// states
	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;
	
	// internal signals
	reg [1:0] state;
	reg [4:0] fall_count;
	
	// flip-flops
	reg [1:0] next_state;
	reg [4:0] next_fall_count;
	
	// combinatorial logic
	always @(*) begin
		case (state)
			IDLE: begin
				aaah = 1;
				walk_left = 1;
				walk_right = 0;
				digging = 0;
				if (areset == 1) begin
					next_state = WALK_LEFT;
					next_fall_count = 0;
				end else if (bump_left == 1) begin
					next_state = WALK_RIGHT;
					next_fall_count = 0;
				end else if (bump_right == 1) begin
					next_state = WALK_LEFT;
					next_fall_count = 0;
				end else if (ground == 0) begin
					next_state = IDLE;
					next_fall_count = fall_count + 1;
				end else if (dig == 1 && ground == 1) begin
					next_state = IDLE;
					next_fall_count = 0;
				end else begin
					next_state = IDLE;
					next_fall_count = 0;
				end
			end
			WALK_LEFT: begin
				aaah = 0;
				walk_left = 1;
				walk_right = 0;
				digging = 0;
				if (bump_left == 1) begin
					next_state = WALK_RIGHT;
					next_fall_count = 0;
				end else if (ground == 0) begin
					next_state = IDLE;
					next_fall_count = fall_count + 1;
				end else if (dig == 1 && ground == 1) begin
					next_state = IDLE;
					next_fall_count = 0;
				end else if (fall_count > 20 && ground == 1) begin
					next_state = IDLE;
					next_fall_count = 0;
				end else begin
					next_state = WALK_LEFT;
					next_fall_count = 0;
				end
			end
			WALK_RIGHT: begin
				aaah = 0;
				walk_left = 0;
				walk_right = 1;
				digging = 0;
				if (bump_right == 1) begin
					next_state = WALK_LEFT;
					next_fall_count = 0;
				end else if (ground == 0) begin
					next_state = IDLE;
					next_fall_count = fall_count + 1;
				end else if (dig == 1 && ground == 1) begin
					next_state = IDLE;
					next_fall_count = 0;
				end else if (fall_count > 20 && ground == 1) begin
					next_state = IDLE;
					next_fall_count = 0;
				end else begin
					next_state = WALK_RIGHT;
					next_fall_count = 0;
				end
			end
		endcase
	end
	
	// state and flip-flop assignments
	always @(posedge clk or posedge areset) begin
		if (areset == 1) begin
			state <= IDLE;
			fall_count <= 0;
		end else if (aaah == 1 || digging == 1 || fall_count > 20) begin
			state <= IDLE;
			if (ground == 1) begin
				fall_count <= 0;
			end
		end else begin
			state <= next_state;
			fall_count <= next_fall_count;
		end
	end
endmodule
