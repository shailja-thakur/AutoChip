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

	// State definition
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} STATE;
	
	// Registers
	reg [2:0] state_reg;
	reg [2:0] state_next;

	// Outputs
	assign walk_left = (state_reg == WALK_LEFT);
	assign walk_right = (state_reg == WALK_RIGHT);
	assign aaah = (state_reg == FALL);
	assign digging = (state_reg == DIG);
	
	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= WALK_LEFT;
		end else begin
			state_reg <= state_next;
		end
	end
	
	// Next state logic
	always @(state_reg or bump_left or bump_right or ground or dig) begin
		case (state_reg)
			WALK_LEFT: begin
				if (bump_right && ground) begin
					state_next = WALK_RIGHT;
				end else if (ground == 0) begin
					state_next = FALL;
				end else if (dig) begin
					state_next = DIG;
				end else begin
					state_next = WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (bump_left && ground) begin
					state_next = WALK_LEFT;
				end else if (ground == 0) begin
					state_next = FALL;
				end else if (dig) begin
					state_next = DIG;
				end else begin
					state_next = WALK_RIGHT;
				end
			end
			FALL: begin
				if (ground) begin
					if (state_reg == WALK_LEFT) begin
						state_next = WALK_LEFT;
					end else begin
						state_next = WALK_RIGHT;
					end
				end else begin
					state_next = FALL;
				end
			end
			DIG: begin
				if (ground) begin
					if (state_reg == WALK_LEFT) begin
						state_next = WALK_LEFT;
					end else begin
						state_next = WALK_RIGHT;
					end
				end else if (dig) begin
					state_next = DIG;
				end else begin
					state_next = FALL;
				end
			end
			default: state_next = WALK_LEFT;
		endcase
	end
	
endmodule
