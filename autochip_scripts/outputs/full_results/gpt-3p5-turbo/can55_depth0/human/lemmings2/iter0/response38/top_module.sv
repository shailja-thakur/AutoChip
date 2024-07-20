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
initial begin
	state = 2'b00;
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00;
	end else begin
		case (state)
			2'b00: begin // walking left
				if (bump_right)
					state <= 2'b01; // walking right
				else if (ground)
					state <= 2'b00; // walking left
				else
					state <= 2'b10; // falling
				end
			2'b01: begin // walking right
				if (bump_left)
					state <= 2'b00; // walking left
				else if (ground)
					state <= 2'b01; // walking right
				else
					state <= 2'b10; // falling
				end
			2'b10: begin // falling
				if (ground)
					state <= state; // remain in falling state until ground disappears
				else if (bump_left || bump_right)
					state <= 2'b10; // continue falling
				else if (state == 2'b00)
					state <= 2'b00; // walking left
				else if (state == 2'b01)
					state <= 2'b01; // walking right
				end
		endcase
	end
end

assign walk_left = (state == 2'b00);
assign walk_right = (state == 2'b01);
assign aaah = (state == 2'b10);

endmodule
