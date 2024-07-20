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

reg [4:0] counter;
reg [1:0] state;

// Define states
parameter left = 2'b00;
parameter right = 2'b01;
parameter fall = 2'b10;
parameter dig = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= left;
		counter <= 0;
	end
	else begin
		case (state)
			left: begin
				if (bump_right & !bump_left) begin
					state <= right;
				end
				else if ((!bump_right & bump_left) || (bump_left & bump_right)) begin
					state <= right;
				end
				else if (!ground & counter == 20) begin
					state <= fall;
				end
				else if (dig & ground) begin
					state <= dig;
				end
			end
			right: begin
				if (bump_left & !bump_right) begin
					state <= left;
				end
				else if ((!bump_right & bump_left) || (bump_left & bump_right)) begin
					state <= left;
				end
				else if (!ground & counter == 20) begin
					state <= fall;
				end
				else if (dig & ground) begin
					state <= dig;
				end
			end
			fall: begin
				if (ground) begin
					state <= state == left ? right : left;
				end
				else if (counter == 20) begin
					state <= fall;
				end
			end
			dig: begin
				if (!ground) begin
					state <= fall;
				end
				else if (counter == 20) begin
					state <= fall;
				end
			end
		endcase
	end
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
		counter <= 0;
	end
	else begin
		case (state)
			left: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			right: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			fall: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end
			dig: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (areset) begin
		counter <= 0;
	end
	else if (!ground) begin
		counter <= counter + 1;
	end
	else begin
		counter <= 0;
	end
end

endmodule
