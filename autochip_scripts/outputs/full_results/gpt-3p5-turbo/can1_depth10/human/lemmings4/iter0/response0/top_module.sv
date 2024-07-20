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
	
	reg [4:0] state;
	initial begin
		state = 5'b10000;
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 5'b10000;
		end else begin
			case (state)
				5'b10000: begin // walking left state
					if (bump_right & ~bump_left & ground) begin
						state <= 5'b01000;
					end else if (dig & ground) begin
						state <= 5'b00100;
					end else if (~ground) begin
						state <= 5'b00010;
					end
				end
				5'b01000: begin // walking right state
					if (bump_left & ~bump_right & ground) begin
						state <= 5'b10000;
					end else if (dig & ground) begin
						state <= 5'b00100;
					end else if (~ground) begin
						state <= 5'b00010;
					end
				end
				5'b00100: begin // digging state
					if (~ground) begin
						state <= 5'b00010;
					end
				end
				5'b00010: begin // falling state
					if (ground) begin
						state <= state;
					end else if (state == 5'b00001) begin
						state <= 5'b00001;
					end else begin
						state <= state - 1;
					end
				end
				5'b00001: begin // splatter state
					state <= 5'b00001;
				end
			endcase
		end
	end
	
	assign walk_left = (state == 5'b10000);
	assign walk_right = (state == 5'b01000);
	assign aaah = (state == 5'b00001);
	assign digging = (state == 5'b00100);
	
endmodule
