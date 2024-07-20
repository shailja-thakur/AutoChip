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
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;

//States
	assign walk_left = (state == 0) ? 1 : 0;
	assign walk_right = (state == 1) ? 1 : 0;
	assign aaah = (state == 2) ? 1 : 0;
	assign digging = (state == 3) ? 1 : 0;

//Next-state and output logic
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 0;
		else
		begin
			case(state)
				0: // walking left state
					if(bump_right)
						state <= 1;
					else if(!ground)
						state <= 2;
					else if(dig)
						state <= 3;
					else
						state <= 0;
				1: // walking right state
					if(bump_left)
						state <= 0;
					else if(!ground)
						state <= 2;
					else if(dig)
						state <= 3;
					else
						state <= 1;
				2: // falling state
					if(ground)
						state <= (bump_left || bump_right) ? (bump_left ? 0 : 1) : (state == 3) ? 3 : (state == 2) ? 2 : (state == 1) ? 1 : 0;
					else
						state <= 2;
				3: // digging state
					if(!ground)
						state <= 2;
					else if(dig)
						state <= 3;
					else
						state <= (bump_left || bump_right) ? (bump_left ? 0 : 1) : (state == 3) ? 3 : (state == 2) ? 2 : (state == 1) ? 1 : 0;
			endcase
		end
	end

endmodule
