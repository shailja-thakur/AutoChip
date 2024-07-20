module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b1;
		end else begin
			case (state)
				2'b00: begin // walking right
					if (bump_left && !bump_right) begin
						state <= 2'b01;
					end else if (!bump_left && bump_right) begin
						state <= 2'b10;
					end else begin
						state <= 2'b00;
					end
				end
				
				2'b01: begin // walking left
					if (bump_left && !bump_right) begin
						state <= 2'b01;
					end else if (!bump_left && bump_right) begin
						state <= 2'b10;
					end else begin
						state <= 2'b00;
					end
				end
				
				2'b10: begin // walking right
					if (bump_left && !bump_right) begin
						state <= 2'b01;
					end else if (!bump_left && bump_right) begin
						state <= 2'b10;
					end else begin
						state <= 2'b00;
					end
				end
			endcase
		end
	end
	
	always @* begin
		case (state)
			2'b00: begin // walking right
				walk_left = 0;
				walk_right = 1;
			end
			
			2'b01: begin // walking left
				walk_left = 1;
				walk_right = 0;
			end
			
			2'b10: begin // walking right
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
endmodule
