module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

// States
parameter [1:0] State_Walk_Left = 2'b00;
parameter [1:0] State_Walk_Right = 2'b01;
parameter [1:0] State_Fall_Aaah = 2'b10;

// Current state
reg [1:0] current_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Reset to initial state
		current_state <= State_Walk_Left;
		// Reset outputs
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
	end else begin
		case (current_state)
			State_Walk_Left: begin
				if (bump_right & !bump_left & ground) begin
					// Switch direction
					current_state <= State_Walk_Right;
					// Set outputs
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (bump_right & !bump_left & !ground) begin
					// Switch direction after fall
					current_state <= State_Fall_Aaah;
					// Set outputs
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end
			end
			
			State_Walk_Right: begin
				if (bump_left & !bump_right & ground) begin
					// Switch direction
					current_state <= State_Walk_Left;
					// Set outputs
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (bump_left & !bump_right & !ground) begin
					// Switch direction after fall
					current_state <= State_Fall_Aaah;
					// Set outputs
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end
			end
			
			State_Fall_Aaah: begin
				if (ground) begin
					// Resume walking in the same direction
					if (current_state == State_Walk_Left) begin
						current_state <= State_Walk_Left;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
					end else begin
						current_state <= State_Walk_Right;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
					end
					// Reset "aaah"
					aaah <= 1'b0;
				end else begin
					// Still falling
					aaah <= 1'b1;
				end
			end
		endcase
	end
end

endmodule
