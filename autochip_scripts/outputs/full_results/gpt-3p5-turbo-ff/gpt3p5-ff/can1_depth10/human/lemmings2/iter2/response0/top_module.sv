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

	reg [1:0] state; // state register

	// define states
	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;

	// initialize state
	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= IDLE; // on reset, set state to IDLE
		end else begin
			case (state)
				IDLE: begin
					if (bump_left & !bump_right) begin
						state <= WALK_RIGHT;
					end else if (!bump_left & bump_right) begin
						state <= WALK_LEFT;
					end else if (bump_left & bump_right) begin
						state <= WALK_RIGHT;
					end else begin
						state <= IDLE;
					end
				end

				WALK_LEFT: begin
					if (!bump_left & bump_right) begin
						state <= WALK_RIGHT;
					end else if (bump_left & bump_right) begin
						state <= WALK_RIGHT;
					end else if (!ground) begin
						state <= IDLE;
					end else begin
						state <= WALK_LEFT;
					end
				end

				WALK_RIGHT: begin
					if (bump_left & !bump_right) begin
						state <= WALK_LEFT;
					end else if (bump_left & bump_right) begin
						state <= WALK_LEFT;
					end else if (!ground) begin
						state <= IDLE;
					end else begin
						state <= WALK_RIGHT;
					end
				end
			endcase
		end
	end

	// output logic
	always @(posedge clk) begin
		case (state)
			IDLE: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 1'b0;
			end

			WALK_LEFT: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 1'b0;
			end

			WALK_RIGHT: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 1'b0;
			end

			default: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 1'b0;
			end
		endcase
	end

endmodule
