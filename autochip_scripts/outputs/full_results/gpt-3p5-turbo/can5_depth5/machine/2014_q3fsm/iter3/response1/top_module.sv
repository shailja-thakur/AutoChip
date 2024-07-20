module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [3:0] current_state;
	reg [3:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= 0;
		else
			current_state <= next_state;
	end
	
	always @(s or w or current_state) begin
		case (current_state)
			0: begin
				if (s)
					next_state = 1;
				else
					next_state = 0;
			end
			
			1: begin
				if (w)
					next_state = 9;
				else
					next_state = 8;
			end
			
			8: begin
				if (w)
					next_state = 11;
				else
					next_state = 10;
			end
			
			9: begin
				if (w)
					next_state = 11;
				else
					next_state = 10;
			end
			
			10: begin
				if (w)
					next_state = 13;
				else
					next_state = 12;
			end
			
			11: begin
				if (w)
					next_state = 13;
				else
					next_state = 12;
			end
			
			12: begin
				next_state = 1;
			end
			
			13: begin
				if (w)
					next_state = 1;
				else
					next_state = 3;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (reset)
			z <= 0;
		else begin
			case (current_state)
				0, 1, 3, 8, 9, 10, 11, 12, 13: begin
					z <= 0;
				end
				default: begin
					z <= 1;
				end
			endcase
		end
	end
endmodule
