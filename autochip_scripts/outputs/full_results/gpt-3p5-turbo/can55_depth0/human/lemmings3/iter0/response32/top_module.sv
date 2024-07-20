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
		state <= 2'b10; // walking left
	end else begin
		case (state)
			2'b00: begin // walking right
				if (bump_right || (bump_left && ground))
					state <= 2'b01; // walking left
				else if (dig && ground)
					state <= 2'b11; // digging
			end
			2'b01: begin // walking left
				if (bump_left || (bump_right && ground))
					state <= 2'b00; // walking right
				else if (dig && ground)
					state <= 2'b11; // digging
			end
			2'b10: begin // falling
				if (ground)
					state <= 2'b00; // walking right
				else if (dig)
					state <= 2'b11; // digging
			end
			2'b11: begin // digging
				if (!ground)
					state <= 2'b10; // falling
				else if (!dig)
					state <= (bump_right || (bump_left && ground)) ? 2'b01 : 2'b00;
			end
		endcase
	end
end

assign walk_left = (state == 2'b01);
assign walk_right = (state == 2'b00);
assign aaah = (state == 2'b10);
assign digging = (state == 2'b11);

endmodule
