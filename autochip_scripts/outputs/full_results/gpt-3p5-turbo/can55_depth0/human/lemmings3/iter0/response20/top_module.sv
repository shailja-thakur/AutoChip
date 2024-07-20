module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output aaah,
	output reg digging
);
	
	// Define states
	typedef enum logic [2:0] {
		LEFT,
		RIGHT,
		FALL,
		DIG_LEFT,
		DIG_RIGHT
	} state_t;
	
	// Define state register
	reg [2:0] state_reg;
	
	// Define next state
	reg [2:0] next_state;
	
	// Define outputs
	assign walk_left = (state_reg == LEFT) || (state_reg == FALL) || (state_reg == DIG_LEFT);
	assign walk_right = (state_reg == RIGHT) || (state_reg == FALL) || (state_reg == DIG_RIGHT);
	assign aaah = (state_reg == FALL);
	assign digging = (state_reg == DIG_LEFT) || (state_reg == DIG_RIGHT);
	
	// Define state machine
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state
			state_reg <= LEFT;
		end else begin
			// Check current state
			case (state_reg)
				LEFT: begin
					if (bump_right && !bump_left) begin
						next_state <= RIGHT;
					end else if (!bump_right && ground && !dig) begin
						next_state <= LEFT;
					end else if (!ground) begin
						next_state <= FALL;
					end else if (dig && (ground && !fall)) begin
						next_state <= DIG_LEFT;
					end else begin
						next_state <= LEFT;
					end
				end
				RIGHT: begin
					if (bump_left && !bump_right) begin
						next_state <= LEFT;
					end else if (!bump_left && ground && !dig) begin
						next_state <= RIGHT;
					end else if (!ground) begin
						next_state <= FALL;
					end else if (dig && (ground && !fall)) begin
						next_state <= DIG_RIGHT;
					end else begin
						next_state <= RIGHT;
					end
				end
				FALL: begin
					if (ground && !dig) begin
						if (state_reg == LEFT) begin
							next_state <= LEFT;
						end else if (state_reg == RIGHT) begin
							next_state <= RIGHT;
						end
					end else begin
						next_state <= FALL;
					end
				end
				DIG_LEFT: begin
					if (!ground) begin
						next_state <= FALL;
					end else if (state_reg == LEFT) begin
						next_state <= DIG_LEFT;
					end else if (state_reg == RIGHT) begin
						next_state <= RIGHT;
					end
				end
				DIG_RIGHT: begin
					if (!ground) begin
						next_state <= FALL;
					end else if (state_reg == LEFT) begin
						next_state <= LEFT;
					end else if (state_reg == RIGHT) begin
						next_state <= DIG_RIGHT;
					end
				end
				default: begin
					next_state <= LEFT;
				end
			endcase
		end
	end
	
	// Update state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= LEFT;
		end else begin
			state_reg <= next_state;
		end
	end
endmodule
