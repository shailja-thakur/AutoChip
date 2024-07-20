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
wire [1:0] next_state;

initial begin
	state <= 2'b00;
end

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @* begin
	case (state)
		2'b00: begin // walking left
			if (bump_left && !bump_right)
				next_state = 2'b01;
			else if (!bump_left && !bump_right)
				next_state = 2'b00;
			else if (!bump_left && bump_right)
				next_state = 2'b00;
			else if (bump_left && bump_right)
				next_state = 2'b01;
		end
		2'b01: begin // walking right
			if (!bump_left && !bump_right)
				next_state = 2'b01;
			else if (bump_left && !bump_right)
				next_state = 2'b00;
			else if (!bump_left && bump_right)
				next_state = 2'b01;
			else if (bump_left && bump_right)
				next_state = 2'b00;
		end
	endcase
end

always @(state, ground, dig) begin
	case (state)
		2'b00: begin // walking left
			walk_left = 1;
			walk_right = 0;
			aaah = (ground == 0) ? 1 : 0;
			digging = 0;
		end
		2'b01: begin // walking right
			walk_left = 0;
			walk_right = 1;
			aaah = (ground == 0) ? 1 : 0;
			digging = 0;
		end
	endcase
end

endmodule
