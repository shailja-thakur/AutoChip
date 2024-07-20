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

reg [1:0] state;
reg [1:0] next_state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk) begin
	if (areset) begin
		state <= WALK_LEFT;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		WALK_LEFT: begin
			if (bump_left == 1) begin
				next_state = WALK_RIGHT;
			end else if (bump_right == 1) begin
				next_state = WALK_LEFT;
			end else if (ground == 0) begin
				next_state = FALL;
			end else if (dig == 1 && ground == 1) begin
				next_state = DIG;
			end else begin
				next_state = WALK_LEFT;
			end
		end
		WALK_RIGHT: begin
			if (bump_left == 1) begin
				next_state = WALK_RIGHT;
			end else if (bump_right == 1) begin
				next_state = WALK_LEFT;
			end else if (ground == 0) begin
				next_state = FALL;
			end else if (dig == 1 && ground == 1) begin
				next_state = DIG;
			end else begin
				next_state = WALK_RIGHT;
			end
		end
		FALL: begin
			next_state = WALK_LEFT;
			if (ground == 1) begin
				next_state = WALK_LEFT;
			end
		end
		DIG: begin
			next_state = DIG;
			if (ground == 0) begin
				next_state = FALL;
			end
		end
	endcase
end

always @(*) begin
	case (state)
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
	endcase
end

endmodule
