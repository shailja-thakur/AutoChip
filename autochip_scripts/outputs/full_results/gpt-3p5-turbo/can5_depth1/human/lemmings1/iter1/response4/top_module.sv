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
			state <= 2'b01;
		end
		else begin
			case (state)
				2'b00: begin
					if (bump_right && !bump_left) begin
						state <= 2'b01;
					end
					else if (bump_right || bump_left) begin
						state <= 2'b10;
					end
					else begin
						state <= 2'b00;
					end
				end
				
				2'b01: begin
					if (!bump_right && !bump_left) begin
						state <= 2'b00;
					end
					else if (bump_right || bump_left) begin
						state <= 2'b10;
					end
					else begin
						state <= 2'b01;
					end
				end
				
				2'b10: begin
					if (!bump_right && bump_left) begin
						state <= 2'b01;
					end
					else if (bump_right || bump_left) begin
						state <= 2'b01;
					end
					else begin
						state <= 2'b10;
					end
				end
				
				default: state <= 2'b00;
			endcase
		end
	end
	
	assign walk_left = (state == 2'b00);
	assign walk_right = (state == 2'b10);
endmodule
