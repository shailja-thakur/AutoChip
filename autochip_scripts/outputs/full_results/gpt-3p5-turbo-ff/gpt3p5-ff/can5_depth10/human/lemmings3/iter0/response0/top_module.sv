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

reg walk_left;
reg walk_right;
reg aaah;
reg digging;

reg [1:0] state;
parameter [1:0] WALK_LEFT = 2'b00;
parameter [1:0] WALK_RIGHT = 2'b01;
parameter [1:0] FALL = 2'b10;
parameter [1:0] DIG = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end
	else begin
		case (state)
			WALK_LEFT: begin
				if (bump_left && !bump_right)
					state <= WALK_RIGHT;
				else if (!bump_left && !bump_right)
					state <= WALK_LEFT;
				else
					state <= FALL;
			end
			
			WALK_RIGHT: begin
				if (!bump_left && bump_right)
					state <= WALK_LEFT;
				else if (!bump_left && !bump_right)
					state <= WALK_RIGHT;
				else
					state <= FALL;
			end
			
			FALL: begin
				if (ground)
					state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
				else
					state <= FALL;
			end
			
			DIG: begin
				if (ground)
					state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
				else if (!ground && digging)
					state <= DIG;
				else
					state <= FALL;
			end
		endcase
        
        case (state)
			WALK_LEFT: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			
			WALK_RIGHT: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			
			FALL: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end
			
			DIG: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end
		endcase
	end
end

endmodule
