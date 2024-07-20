module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

// State declaration
reg [1:0] state;
parameter IDLE = 2'b00;
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

// Output declaration
reg walk_left;
reg walk_right;
reg aaah;

// State transition logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
	end else begin
		case(state)
			IDLE: begin
				if (areset) begin
					state <= IDLE;
				end else if (bump_left && !bump_right) begin
					state <= WALK_RIGHT;
				end else if (bump_right && !bump_left) begin
					state <= WALK_LEFT;
				end else if (bump_left && bump_right) begin
					state <= WALK_RIGHT;
				end else begin
					state <= IDLE;
				end
			end
			WALK_LEFT: begin
				if (areset) begin
					state <= IDLE;
				end else if (ground) begin
					state <= WALK_LEFT;
				end else begin
					state <= IDLE;
				end
			end
			WALK_RIGHT: begin
				if (areset) begin
					state <= IDLE;
				end else if (ground) begin
					state <= WALK_RIGHT;
				end else begin
					state <= IDLE;
				end
			end
		endcase
	end
end

// Output logic
always @(state) begin
	walk_left = 0;
	walk_right = 0;
	aaah = 0;
	
	case(state)
		WALK_LEFT: begin
			walk_left = 1;
		end
		WALK_RIGHT: begin
			walk_right = 1;
		end
		IDLE: begin
			if (!ground) begin
				aaah = 1;
			end
		end
	endcase
end

endmodule
