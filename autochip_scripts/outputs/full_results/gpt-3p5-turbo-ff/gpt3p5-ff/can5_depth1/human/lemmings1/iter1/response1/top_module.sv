module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);
	reg walking_direction;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			walking_direction <= 1'b0; // Start by walking left
		end
		else begin
			case (walking_direction)
				1'b0: begin // If walking left
					if (bump_right) begin // Switch direction if bumped on the right
						walking_direction <= 1'b1;
					end
				end
				1'b1: begin // If walking right
					if (bump_left) begin // Switch direction if bumped on the left
						walking_direction <= 1'b0;
					end
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (walking_direction == 1'b0) begin // Output signals based on current walking direction
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end
		else begin
			walk_left <= 1'b0;
			walk_right <= 1'b1;
		end
	end

endmodule
