module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b10;
		end else begin
			case (state)
				2'b10: begin // walking left state
					if (bump_left && !bump_right) begin
						state <= 2'b01;
					end else if (!bump_left && bump_right) begin
						state <= 2'b00;
					end else if (bump_left && bump_right) begin
						state <= 2'b00;
					end
				end
				2'b01: begin // walking right state
					if (!bump_left && bump_right) begin
						state <= 2'b10;
					end else if (bump_left && !bump_right) begin
						state <= 2'b00;
					end else if (bump_left && bump_right) begin
						state <= 2'b00;
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b10: begin // walking left state
				walk_left = 1;
				walk_right = 0;
			end
			2'b01: begin // walking right state
				walk_left = 0;
				walk_right = 1;
			end
			default: begin // default state
				walk_left = 0;
				walk_right = 0;
			end
		endcase
	end
endmodule
