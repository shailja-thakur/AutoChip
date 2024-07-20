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

	typedef enum reg [2:0] {
		LEFT       = 3'b000,
		RIGHT      = 3'b001,
		FALLING_L  = 3'b010,
		FALLING_R  = 3'b011,
		DIGGING_L  = 3'b100,
		DIGGING_R  = 3'b101,
		SPLATTERED = 3'b110
	} state_t;
	
	state_t state, next_state;
	reg [4:0] fall_count;
	
	always @(*) begin
		case (state)
			LEFT: begin
				if (!ground)
					next_state = FALLING_L;
				else if (dig)
					next_state = DIGGING_L;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (!ground)
					next_state = FALLING_R;
				else if (dig)
					next_state = DIGGING_R;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALLING_L: begin
				if (ground) begin
					if (fall_count > 20)
						next_state = SPLATTERED;
					else
						next_state = LEFT;
				end else
					next_state = FALLING_L;
			end
			FALLING_R: begin
				if (ground) begin
					if (fall_count > 20)
						next_state = SPLATTERED;
					else
						next_state = RIGHT;
				end else
					next_state = FALLING_R;
			end
			DIGGING_L: begin
				if (!ground)
					next_state = FALLING_L;
				else
					next_state = DIGGING_L;
			end
			DIGGING_R: begin
				if (!ground)
					next_state = FALLING_R;
				else
					next_state = DIGGING_R;
			end
			SPLATTERED: next_state = SPLATTERED;
			default: next_state = LEFT;
		endcase
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			fall_count <= 0;
		end else begin
			if (state == FALLING_L || state == FALLING_R) begin
				fall_count <= fall_count + 1;
			end else begin
				fall_count <= 0;
			end
			state <= next_state;
		end
	end
	
	always @(*) begin
		walk_left = (state == LEFT);
		walk_right = (state == RIGHT);
		aaah = (state == FALLING_L || state == FALLING_R);
		digging = (state == DIGGING_L || state == DIGGING_R);
	end
endmodule
