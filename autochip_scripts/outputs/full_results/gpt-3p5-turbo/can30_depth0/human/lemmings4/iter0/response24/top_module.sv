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

parameter [4:0] WALK_LEFT = 5'b00001; // State for walking left
parameter [4:0] WALK_RIGHT = 5'b00010; // State for walking right
parameter [4:0] FALL = 5'b00100; // State for falling
parameter [4:0] DIG = 5'b01000; // State for digging
parameter [4:0] SPLATTER = 5'b10000; // State for splattering

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= WALK_LEFT;
	else if (state == WALK_LEFT)
	begin
		// Check for state transitions
		if (bump_right)
			state <= WALK_RIGHT;
		else if (ground == 0)
			state <= FALL;
		else if (dig)
			state <= DIG;
		end
	else if (state == WALK_RIGHT)
	begin
		// Check for state transitions
		if (bump_left)
			state <= WALK_LEFT;
		else if (ground == 0)
			state <= FALL;
		else if (dig)
			state <= DIG;
		end
	else if (state == FALL)
	begin
		// Check for state transitions
		if (ground)
			state <= walk_left ? WALK_LEFT : WALK_RIGHT;
		else if (state == FALL && ((bump_left || bump_right) && ground == 0))
			state <= FALL;
		else if (state == FALL && ((bump_left || bump_right) && ground))
			state <= walk_left ? WALK_LEFT : WALK_RIGHT;
		end
	else if (state == DIG)
	begin
		// Check for state transitions
		if (ground == 0)
			state <= FALL;
		else if (!dig || (bump_left || bump_right))
			state <= walk_left ? WALK_LEFT : WALK_RIGHT;
		end
	else if (state == SPLATTER)
	begin
		// No state transitions possible, stuck in splattered state
		state <= SPLATTER;
	end
end

always @(*)
begin
	// Default outputs
	walk_left = 0;
	walk_right = 0;
	aaah = 0;
	digging = 0;
	
	// State based logic for outputs
	case (state)
		WALK_LEFT: walk_left = 1;
		WALK_RIGHT: walk_right = 1;
		FALL: aaah = 1;
		DIG: digging = 1;
	endcase
end

endmodule
