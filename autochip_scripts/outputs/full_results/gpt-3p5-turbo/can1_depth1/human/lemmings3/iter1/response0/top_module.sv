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
	
	// Define state enum
	typedef enum logic [2:0] {
		walking_left,
		walking_right,
		falling,
		digging_state
	} state_t;
	
	// Define state register
	reg [2:0] current_state;
	
	// Define next state register
	reg [2:0] next_state;
	
	// Define outputs
	assign walk_left = (current_state == walking_left);
	assign walk_right = (current_state == walking_right);
	assign aaah = (current_state == falling);
	assign digging = (current_state == digging_state);
	
	// Define state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state to walking_left
			current_state <= walking_left;
		end else begin
			// Update next state based on current state and inputs
			case (current_state)
				walking_left: begin
					if (bump_right) begin
						next_state <= walking_right;
					end else if (dig && ground) begin
						next_state <= digging_state;
					end else if (!ground) begin
						next_state <= falling;
					end else begin
						next_state <= walking_left;
					end
				end
				
				walking_right: begin
					if (bump_left) begin
						next_state <= walking_left;
					end else if (dig && ground) begin
						next_state <= digging_state;
					end else if (!ground) begin
						next_state <= falling;
					end else begin
						next_state <= walking_right;
					end
				end
				
				falling: begin
					if (ground) begin
						if (bump_right) begin
							next_state <= walking_right;
						end else if (bump_left) begin
							next_state <= walking_left;
						end else begin
							next_state <= current_state;
						end
					end else begin
						next_state <= falling;
					end
				end
				
				digging_state: begin
					if (!ground || !dig) begin
						next_state <= falling;
					end else begin
						next_state <= digging_state;
					end
				end
			endcase
		end
	end
	
	// Update current state with next state after output is assigned
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= walking_left;
		end else begin
			current_state <= next_state;
		end
	end
	
endmodule
