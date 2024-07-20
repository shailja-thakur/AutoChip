module top_module(
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	// Define states
	typedef enum {
		Walking_Left,
		Walking_Right,
		Falling
	} state_t;
	
	// Define signals
	reg [1:0] current_state;
	reg [1:0] next_state;
	reg walk_left;
	reg walk_right;
	reg aaah;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= Walking_Left;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end else begin
			current_state <= next_state;
			case(current_state)
				Walking_Left:
					if (bump_left) begin
						next_state <= Walking_Right;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
					end else if (bump_right) begin
						next_state <= Walking_Left;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
					end else if (!ground) begin
						next_state <= Falling;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end else begin
						next_state <= Walking_Left;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
					end
				Walking_Right:
					if (bump_right) begin
						next_state <= Walking_Left;
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
					end else if (bump_left) begin
						next_state <= Walking_Right;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
					end else if (!ground) begin
						next_state <= Falling;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end else begin
						next_state <= Walking_Right;
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
					end
				Falling:
					if (ground) begin
						next_state <= current_state;
						walk_left <= (current_state == Walking_Left) ? 1 : 0;
						walk_right <= (current_state == Walking_Right) ? 1 : 0;
						aaah <= 0;
					end else begin
						next_state <= Falling;
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end
			endcase
		end
	end
	
endmodule
