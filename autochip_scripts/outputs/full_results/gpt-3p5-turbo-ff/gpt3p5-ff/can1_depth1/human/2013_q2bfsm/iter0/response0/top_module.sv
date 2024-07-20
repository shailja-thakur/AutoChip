module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [1:0] state, next_state;
	reg f, g;
	
	always@(posedge clk or negedge resetn) begin
		if (~resetn) begin
			// reset state and outputs
			state <= 2'b0;
			f <= 1'b0;
			g <= 1'b0;
		end else begin
			// sequential logic
			state <= next_state;
			f <= 1'b0;
			g <= 1'b0;
			
			// combinational logic
			case (state)
				2'b00: begin // State A
					if (x == 1'b1 && $past(x) == 1'b0 && $past($past(x)) == 1'b1)
						next_state = 2'b01;
					else
						next_state = 2'b00;
				end
				
				2'b01: begin // State B
					f <= 1'b1;
					next_state = 2'b10;
				end
				
				2'b10: begin // State C
					if (x == 1'b0 && $past(x) == 1'b1 && $past($past(x)) == 1'b0)
						next_state = 2'b11;
					else
						next_state = 2'b10;
				end
				
				2'b11: begin // State D
					if (y == 1'b1) begin
						g <= 1'b1;
						next_state = 2'b11;
					end else if ($past(g) == 1'b1 && $past(y) == 1'b0) begin
						g <= 1'b0;
						next_state = 2'b11;
					end else begin
						g <= 1'b0;
						next_state = 2'b00;
					end
				end
			endcase
		end
	end
endmodule
