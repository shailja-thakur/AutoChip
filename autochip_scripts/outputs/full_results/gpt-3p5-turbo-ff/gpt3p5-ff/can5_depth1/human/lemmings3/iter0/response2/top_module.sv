module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);
	reg [1:0] state;
	reg [1:0] next_state;
	reg [1:0] direction;
	reg falling;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
			direction <= 2'b01; // Walking left
		end else begin
			state <= next_state;
			direction <= (state == 2'b00) ? (bump_right ? 2'b00 : 2'b01) :
			             (state == 2'b01) ? (bump_left ? 2'b01 : 2'b00) :
						 direction;
		end
	end

	always @(state, ground, falling) begin
		case (state)
			2'b00: begin // Walking left
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
				next_state = (falling == 1) ? 2'b10 : 2'b00;
			end

			2'b01: begin // Walking right
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
				next_state = (falling == 1) ? 2'b10 : 2'b01;
			end

			2'b10: begin // Falling
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
				next_state = (ground == 1) ? direction : 2'b10;
			end

			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
				next_state = 2'b00;
			end
		endcase
	end

	always @(posedge clk) begin
		falling <= (state == 2'b00 && ground == 0) ? 1 :
		           (state == 2'b01 && ground == 0) ? 1 :
				   (state == 2'b10 && ground == 0) ? 1 : 0;
	end
endmodule
