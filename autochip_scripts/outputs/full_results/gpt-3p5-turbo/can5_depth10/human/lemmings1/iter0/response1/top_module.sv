module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] state;
reg internal_output;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b01; // initialize state to walking left
		internal_output <= 1'b1; // initialize internal output to walk_left
	end
	else begin
		case (state)
			2'b01: begin // walking left state
				if (bump_right) begin // switch to walking right if bumped on the right
					state <= 2'b10;
				end
				else if (bump_left) begin // continue walking left if bumped on the left
					state <= 2'b01;
				end
				else begin // continue walking left if not bumped on any side
					state <= 2'b01;
				end
			end
			
			2'b10: begin // walking right state
				if (bump_left) begin // switch to walking left if bumped on the left
					state <= 2'b01;
				end
				else if (bump_right) begin // continue walking right if bumped on the right
					state <= 2'b10;
				end
				else begin // continue walking right if not bumped on any side
					state <= 2'b10;
				end
			end
		endcase
	end
end

assign walk_left = (state == 2'b01);
assign walk_right = (state == 2'b10);

endmodule
