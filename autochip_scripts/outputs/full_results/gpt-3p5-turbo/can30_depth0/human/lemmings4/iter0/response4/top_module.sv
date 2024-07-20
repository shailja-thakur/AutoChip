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

reg [4:0] state;
reg [4:0] count;

parameter [4:0] WALK_LEFT = 5'b00001;
parameter [4:0] WALK_RIGHT = 5'b00010;
parameter [4:0] FALL = 5'b00011;
parameter [4:0] DIG = 5'b00100;
parameter [4:0] SPLATTER = 5'b10000;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= WALK_LEFT;
	else begin
		case(state)
			WALK_LEFT: begin
				if (bump_right)
					state <= WALK_RIGHT;
				else if (bump_left && !bump_right)
					state <= WALK_LEFT;
				else if (dig && ground)
					state <= DIG;
				else if (!ground)
					state <= FALL;
			end
			WALK_RIGHT: begin
				if (bump_left)
					state <= WALK_LEFT;
				else if (bump_left && !bump_right)
					state <= WALK_RIGHT;
				else if (dig && ground)
					state <= DIG;
				else if (!ground)
					state <= FALL;
			end
			FALL: begin
				if (ground)
					state <= state[3:0];
				else begin
					if (count == 20)
						state <= SPLATTER;
					else
						state <= FALL;
				end
			end
			DIG: begin
				if (!ground)
					state <= DIG;
				else
					state <= state[3:0];
			end
			SPLATTER: begin
				state <= SPLATTER;
			end
		endcase
	end
end

always @(state) begin
	case(state)
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
		SPLATTER: begin
			walk_left = 0;
			walk_right = 0;
			aaah = 0;
			digging = 0;
		end
	endcase
end

always @(posedge clk) begin
	if (areset)
		count <= 0;
	else begin
		if (ground)
			count <= 0;
		else if (!ground && state == FALL)
			count <= count + 1;
	end
end

endmodule
