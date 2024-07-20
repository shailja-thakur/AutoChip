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

reg [4:0] state;

parameter IDLE = 5'b00000;
parameter WALK_LEFT = 5'b00001;
parameter WALK_RIGHT = 5'b00010;
parameter FALL = 5'b00011;
parameter DIG = 5'b00100;
parameter SPLATTER = 5'b00101;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
	end else begin 
		case(state)
			IDLE: begin
				if (areset)
					state <= IDLE;
				else if (bump_left)
					state <= WALK_RIGHT;
				else if (bump_right)
					state <= WALK_LEFT;
				else if (!ground)
					state <= FALL;
				else if (dig && ground)
					state <= DIG;
			end
			WALK_LEFT: begin
				if (areset)
					state <= IDLE;
				else if (bump_right)
					state <= WALK_LEFT;
				else if (!ground)
					state <= FALL;
				else if (dig && ground)
					state <= DIG;
			end
			WALK_RIGHT: begin
				if (areset)
					state <= IDLE;
				else if (bump_left)
					state <= WALK_RIGHT;
				else if (!ground)
					state <= FALL;
				else if (dig && ground)
					state <= DIG;
			end
			FALL: begin
				if (areset)
					state <= IDLE;
				else if (ground)
					state <= IDLE;
				else if (state_count >= 20)
					state <= SPLATTER;
			end
			DIG: begin
				if (areset)
					state <= IDLE;
				else if (!ground)
					state <= FALL;
				else if (!dig)
					state <= IDLE;
			end
			SPLATTER: begin
				if (areset)
					state <= IDLE;
			end
		endcase
	end
end

always @(state) begin
	case(state)
		IDLE: begin
			walk_left = 1;
			walk_right = 0;
			aaah = 0;
			digging = 0;
		end
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

endmodule
