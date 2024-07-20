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

	// initialize state and outputs
	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= IDLE;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					if (bump_left & !bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
					end else if (!bump_left & bump_right) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end
				end

				WALK_LEFT: begin
					if (!bump_left & bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
					end else if (!ground) begin
						state <= IDLE;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end
				end

				WALK_RIGHT: begin
					if (bump_left & !bump_right) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end else if (!ground) begin
						state <= IDLE;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end
				end
			endcase
		end
	end

	// handle falling
	always @(posedge clk) begin
		if (ground == 1'b0) begin
			aaah <= 1'b1;
		end
	end

endmodule
