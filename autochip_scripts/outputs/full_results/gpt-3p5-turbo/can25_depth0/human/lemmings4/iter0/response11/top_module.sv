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
	reg [5:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 6'b1;
		end else begin
			case (state)
				6'b1: if (ground) begin
					state <= 6'b001;
				end else if (bump_left && bump_right) begin
					state <= 6'b010;
				end else if (bump_left) begin
					state <= 6'b100;
				end else if (bump_right) begin
					state <= 6'b101;
				end else begin
					state <= 6'b001;
				end
				6'b001: if (!ground) begin
					state <= 6'b010;
				end else begin
					state <= 6'b001;
				end
				6'b010: if (dig && ground) begin
					state <= 6'b011;
				end else if (!ground) begin
					state <= 6'b011;
				end else if (bump_left && bump_right) begin
					state <= 6'b010;
				end else if (bump_left) begin
					state <= 6'b100;
				end else if (bump_right) begin
					state <= 6'b101;
				end else begin
					state <= 6'b010;
				end
				6'b011: if (!ground) begin
					state <= 6'b010;
				end else begin
					state <= 6'b011;
				end
				6'b100: if (!ground) begin
					state <= 6'b110;
				end else begin
					state <= 6'b100;
				end
				6'b101: if (!ground) begin
					state <= 6'b011;
				end else begin
					state <= 6'b101;
				end
				6'b110: if (!ground) begin
					state <= 6'b010;
				end else begin
					state <= 6'b001;
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			6'b1, 6'b001, 6'b010, 6'b011: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			6'b100, 6'b101, 6'b110: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			default: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah = 1;
				digging <= 0;
			end
		endcase
	end
endmodule
