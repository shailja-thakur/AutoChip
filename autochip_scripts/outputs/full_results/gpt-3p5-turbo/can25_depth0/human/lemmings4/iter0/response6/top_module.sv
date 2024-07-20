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
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

// State Definitions
parameter WALK_LEFT_STATE = 3'b000;
parameter WALK_RIGHT_STATE = 3'b001;
parameter FALLING_STATE = 3'b010;
parameter DIGGING_STATE = 3'b011;
parameter SPLATTERED_STATE = 3'b100;

// State Assignments
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT_STATE;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end else begin
		case (state)
			WALK_LEFT_STATE: begin
				if (bump_right == 1)
					state <= WALK_RIGHT_STATE;
				else if (ground == 0)
					state <= FALLING_STATE;
				else if (dig == 1 && ground == 1)
					state <= DIGGING_STATE;
			end
			WALK_RIGHT_STATE: begin
				if (bump_left == 1)
					state <= WALK_LEFT_STATE;
				else if (ground == 0)
					state <= FALLING_STATE;
				else if (dig == 1 && ground == 1)
					state <= DIGGING_STATE;
			end
			FALLING_STATE: begin
				if (ground == 1)
					state <= state[1:0] == WALK_LEFT_STATE ? WALK_LEFT_STATE : WALK_RIGHT_STATE;
			end
			DIGGING_STATE: begin
				if (ground == 0)
					state <= FALLING_STATE;
			end
			SPLATTERED_STATE: begin
				// Remain in splattered state
			end
		endcase
	end
end

// Output Assignments
always @(state) begin
	case (state)
		WALK_LEFT_STATE: begin
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end
		WALK_RIGHT_STATE: begin
			walk_left <= 0;
			walk_right <= 1;
			aaah <= 0;
			digging <= 0;
		end
		FALLING_STATE: begin
			walk_left <= 0;
			walk_right <= 0;
			aaah <= 1;
			digging <= 0;
		end
		DIGGING_STATE: begin
			walk_left <= 0;
			walk_right <= 0;
			aaah <= 0;
			digging <= 1;
		end
		SPLATTERED_STATE: begin
			walk_left <= 0;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end
	endcase
end

endmodule
