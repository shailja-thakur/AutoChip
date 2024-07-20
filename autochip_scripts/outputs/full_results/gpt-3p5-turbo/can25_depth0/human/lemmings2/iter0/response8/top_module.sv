module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	reg [1:0] state;
	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					if (bump_left) begin
						state <= WALK_RIGHT;
					end else if (bump_right) begin
						state <= WALK_LEFT;
					end
				end
				WALK_LEFT: begin
					if (bump_left && bump_right) begin
						state <= WALK_RIGHT;
					end else if (bump_right) begin
						state <= WALK_LEFT;
					end else if (ground) begin
						state <= WALK_LEFT;
					end
				end
				WALK_RIGHT: begin
					if (bump_right && bump_left) begin
						state <= WALK_LEFT;
					end else if (bump_left) begin
						state <= WALK_RIGHT;
					end else if (ground) begin
						state <= WALK_RIGHT;
					end
				end
			endcase
		end
	end

	always @(state) begin
		case(state)
			IDLE: begin
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
			end
			WALK_LEFT: begin
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
			end
			WALK_RIGHT: begin
				walk_left <= 1'b0;
				walk_right <= 1'b1;
				aaah <= 1'b0;
			end
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			aaah <= 1'b0;
		end else begin
			case(state)
				IDLE: begin
					if (ground == 0) begin
						aaah <= 1'b1;
					end else begin
						aaah <= 1'b0;
					end
				end
				WALK_LEFT: begin
					if (ground == 0) begin
						aaah <= 1'b1;
					end else begin
						aaah <= 1'b0;
					end
				end
				WALK_RIGHT: begin
					if (ground == 0) begin
						aaah <= 1'b1;
					end else begin
						aaah <= 1'b0;
					end
				end
			endcase
		end
	end
endmodule
