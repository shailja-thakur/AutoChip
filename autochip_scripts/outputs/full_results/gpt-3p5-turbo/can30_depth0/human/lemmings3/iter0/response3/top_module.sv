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
	// Define states
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_type;

	// Define signals
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	// Default assignments
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state == FALL);
	assign digging = (current_state == DIG);

	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin
		next_state = current_state;
		// State transition logic
		case (current_state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end else if (!ground) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state = WALK_LEFT;
				end else if (!ground) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end
			FALL: begin
				if (ground) begin
					if (current_state == WALK_LEFT) begin
						next_state = WALK_LEFT;
					end else if (current_state == WALK_RIGHT) begin
						next_state = WALK_RIGHT;
					end
				end
			end
			DIG: begin
				if (!ground) begin
					next_state = FALL;
				end
			end
		endcase
	end
endmodule
