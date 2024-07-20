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
	reg [4:0] next_state;
	initial begin
		state = 5'b10000;
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 5'b10000;
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		case (state)
			5'b10000: begin // walking left state
				if (bump_right & ~bump_left) begin
					next_state = 5'b01000;
				end else if (dig & ground) begin
					next_state = 5'b00100;
				end else if (~ground) begin
					next_state = 5'b00010;
				end else begin
					next_state = 5'b10000;
				end
			end
			5'b01000: begin // walking right state
				if (bump_left & ~bump_right) begin
					next_state = 5'b10000;
				end else if (dig & ground) begin
					next_state = 5'b00100;
				end else if (~ground) begin
					next_state = 5'b00010;
				end else begin
					next_state = 5'b01000;
				end
			end
			5'b00100: begin // digging state
				if (~ground) begin
					next_state = 5'b00010;
				end else begin
					next_state = 5'b00100;
				end
			end
			5'b00010: begin // falling state
				if (ground) begin
					next_state = 5'b10000;
				end else if (state == 5'b00001) begin
					next_state = 5'b00001;
				end else begin
					next_state = state - 1;
				end
			end
			5'b00001: begin // splatter state
				next_state = 5'b00001;
			end
		endcase
	end
	
	assign walk_left = (state == 5'b10000);
	assign walk_right = (state == 5'b01000);
	assign aaah = (state == 5'b00001);
	assign digging = (state == 5'b00100);
	
endmodule
