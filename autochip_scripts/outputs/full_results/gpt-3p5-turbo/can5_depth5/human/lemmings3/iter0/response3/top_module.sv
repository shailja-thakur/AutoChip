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
reg walking_left;
reg walking_right;
reg falling;
reg digging;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b10; // start in walking left state
		walking_left <= 1;
		walking_right <= 0;
		falling <= 0;
		digging <= 0;
	end else begin
		case(state)
			2'b00: begin // walking right state
				if (bump_left || (bump_left && bump_right) || dig) begin
					state <= 2'b01;
					walking_left <= 1;
					walking_right <= 0;
					falling <= 0;
					digging <= 0;
				end else if (ground == 0) begin
					state <= 2'b10; // falling state
					walking_left <= 0;
					walking_right <= 0;
					falling <= 1;
					digging <= 0;
				end
			end
			2'b01: begin // walking left state
				if (bump_right || (bump_left && bump_right) || dig) begin
					state <= 2'b00;
					walking_left <= 0;
					walking_right <= 1;
					falling <= 0;
					digging <= 0;
				end else if (ground == 0) begin
					state <= 2'b10; // falling state
					walking_left <= 0;
					walking_right <= 0;
					falling <= 1;
					digging <= 0;
				end
			end
			2'b10: begin // falling state
				if (ground == 1) begin
					state <= walking_right ? 2'b00 : 2'b01;
					walking_left <= walking_right ? 0 : 1;
					walking_right <= walking_right ? 1 : 0;
					falling <= 0;
					digging <= 0;
				end else if (dig) begin
					state <= 2'b11; // digging state
					walking_left <= 0;
					walking_right <= 0;
					falling <= 0;
					digging <= 1;
				end
			end
			2'b11: begin // digging state
				if (ground == 0) begin
					state <= 2'b10; // falling state
					walking_left <= 0;
					walking_right <= 0;
					falling <= 1;
					digging <= 0;
				end else if (dig == 0) begin
					state <= walking_right ? 2'b00 : 2'b01;
					walking_left <= walking_right ? 0 : 1;
					walking_right <= walking_right ? 1 : 0;
					falling <= 0;
					digging <= 0;
				end
			end
		endcase
	end
end

assign walk_left = walking_left;
assign walk_right = walking_right;
assign aaah = falling;
assign digging = digging;

endmodule
