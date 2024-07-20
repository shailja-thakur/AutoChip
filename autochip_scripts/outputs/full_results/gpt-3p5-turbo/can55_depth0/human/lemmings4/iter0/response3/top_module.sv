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
				2'b10: begin  // walking left
					if (bump_right) begin
						state <= 2'b01;  // walking right
					end else if (!ground) begin
						state <= 2'b00;  // falling
					end else if (dig) begin
						state <= 2'b11;  // digging
					end
				end
				2'b01: begin  // walking right
					if (bump_left) begin
						state <= 2'b10;  // walking left
					end else if (!ground) begin
						state <= 2'b00;  // falling
					end else if (dig) begin
						state <= 2'b11;  // digging
					end
				end
				2'b00: begin  // falling
					if (ground) begin
						state <= 2'b10;  // walking left
					end else if (dig) begin
						state <= 2'b11;  // digging
					end else if (state_duration >= 20) begin
						state <= 2'b00;  // splatter
					end
				end
				2'b11: begin  // digging
					if (!ground) begin
						state <= 2'b00;  // falling
					end else if (dig) begin
						state <= 2'b11;  // digging
					end
				end
			endcase
		end
	end

	assign walk_left = (state == 2'b10);
	assign walk_right = (state == 2'b01);
	assign aaah = (state == 2'b00);
	assign digging = (state == 2'b11);

endmodule
