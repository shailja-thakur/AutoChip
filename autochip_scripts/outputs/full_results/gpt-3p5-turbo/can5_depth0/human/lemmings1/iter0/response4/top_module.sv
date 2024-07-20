module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	reg [1:0] state;
    reg [1:0] next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // walking left
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			2'b00: begin // walking right
				if (bump_left && bump_right) begin // bumped on both sides
					next_state = 2'b01; // switch to walking left
				end else if (bump_left) begin // bumped on the left side
					next_state = 2'b00; // continue walking right
				end else if (bump_right) begin // bumped on the right side
					next_state = 2'b01; // switch to walking left
				end
			end
			
			2'b01: begin // walking left
				if (bump_left && bump_right) begin // bumped on both sides
					next_state = 2'b00; // switch to walking right
				end else if (bump_left) begin // bumped on the left side
					next_state = 2'b01; // continue walking left
				end else if (bump_right) begin // bumped on the right side
					next_state = 2'b00; // switch to walking right
				end
			end
		endcase
	end
	
	assign walk_left = (state == 2'b01) ? 1'b1 : 1'b0;
	assign walk_right = (state == 2'b00) ? 1'b1 : 1'b0;
endmodule
