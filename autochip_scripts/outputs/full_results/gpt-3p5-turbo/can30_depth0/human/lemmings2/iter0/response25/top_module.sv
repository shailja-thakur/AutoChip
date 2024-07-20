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
reg walk_left;
reg walk_right;
reg aaah;

parameter S0 = 2'b00; // walking left
parameter S1 = 2'b01; // walking right
parameter S2 = 2'b10; // falling
parameter S3 = 2'b11; // recovering from fall

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S0;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end else begin
		case (state)
			S0: begin // walking left
				if (bump_right) begin
					state <= S1;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end else if (!ground) begin
					state <= S2;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			end
			S1: begin // walking right
				if (bump_left) begin
					state <= S0;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end else if (!ground) begin
					state <= S2;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			end
			S2: begin // falling
				if (ground) begin
					state <= S3;
					walk_left <= (state == S0) ? 1 : 0;
					walk_right <= (state == S1) ? 1 : 0;
					aaah <= 0;
				end
			end
			S3: begin // recovering from fall
				if (!ground) begin
					state <= S2;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end else begin
					state <= (state == S0) ? S0 : S1;
					walk_left <= (state == S0) ? 1 : 0;
					walk_right <= (state == S1) ? 1 : 0;
					aaah <= 0;
				end
			end
		endcase
	end
end

endmodule
