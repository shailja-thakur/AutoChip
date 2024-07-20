module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end
		else begin
			case (state)
				2'b00: begin // walking left
					if (bump_right) begin
						state <= 2'b01;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
						digging <= 1'b0;
					end 
					else if (dig && ground) begin
						state <= 2'b11;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;
					end 
					else if (!ground) begin
						state <= 2'b10;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;
						digging <= 1'b0;
					end
				end
				2'b01: begin // walking right
					if (bump_left) begin
						state <= 2'b00;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end 
					else if (dig && ground) begin
						state <= 2'b11;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b1;
					end 
					else if (!ground) begin
						state <= 2'b10;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;
						digging <= 1'b0;
					end
				end
				2'b10: begin // falling
					if (ground) begin
						state <= 2'b00;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
						digging <= 1'b0;
					end
				end
				2'b11: begin // digging
					if (!ground) begin
						state <= 2'b10;
						walk_left <= 1'b0;
						walk_right <= 1'b0;
						aaah <= 1'b1;
						digging <= 1'b0;
					end
				end
			endcase
		end
	end

endmodule
