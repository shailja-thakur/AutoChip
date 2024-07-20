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
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b10;  // walking left
		end else begin
			case (state)
				2'b00: begin  // falling
					if (ground) begin
						state <= 2'b10;  // resume walking
					end else begin
						state <= 2'b00;  // continue falling
					end
				end
				2'b01: begin  // walking right
					if (bump_left && bump_right) begin
						state <= 2'b10;  // switch directions
					end else begin
						if (bump_left) begin
							state <= 2'b10;  // switch to walking right
						end else if (bump_right) begin
							state <= 2'b01;  // continue walking right
						end else if (dig && ground) begin
							state <= 2'b11;  // start digging
						end else begin
							state <= 2'b01;  // continue walking right
						end
					end
				end
				2'b10: begin  // walking left
					if (bump_left && bump_right) begin
						state <= 2'b01;  // switch directions
					end else begin
						if (bump_left) begin
							state <= 2'b10;  // continue walking left
						end else if (bump_right) begin
							state <= 2'b01;  // switch to walking right
						end else if (dig && ground) begin
							state <= 2'b11;  // start digging
						end else begin
							state <= 2'b10;  // continue walking left
						end
					end
				end
				2'b11: begin  // digging
					if (!ground) begin
						state <= 2'b00;  // fall after digging
					end else begin
						state <= 2'b11;  // continue digging
					end
				end
				default: state <= 2'b10;
			endcase
		end
	end

	assign walk_left = (state == 2'b10);
	assign walk_right = (state == 2'b01);
	assign aaah = (state == 2'b00);
	assign digging = (state == 2'b11);
endmodule
