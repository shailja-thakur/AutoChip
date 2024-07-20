module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b10; // Initialize state to walking left
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			2'b00: begin // Walking right state
				if (bump_left || (bump_left && bump_right)) begin
					next_state = 2'b01; // Switch to walking left state
				end else begin
					next_state = state;
				end
			end
			2'b01: begin // Walking left state
				if (bump_right || (bump_left && bump_right)) begin
					next_state = 2'b00; // Switch to walking right state
				end else begin
					next_state = state;
				end
			end
			default: begin
				next_state = 2'b10; // Default to walking left state
			end
		endcase
	end
	
	assign walk_left = (state == 2'b01) ? 1'b1 : 1'b0;
	assign walk_right = (state == 2'b00) ? 1'b1 : 1'b0;
	
endmodule
