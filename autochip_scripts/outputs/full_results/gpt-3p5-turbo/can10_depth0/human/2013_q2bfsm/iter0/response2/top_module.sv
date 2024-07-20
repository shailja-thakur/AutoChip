module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or negedge resetn)
		begin
			if (~resetn)
				state <= 2'b00;  // state A
			else
				state <= next_state;
		end
	
	always @(state or x or y)
		begin
			case (state)
				0: begin  // state A
					if (resetn)
						begin
							f <= 1'b0;
							g <= 1'b0;
							if (x)
								next_state <= 2'b01;  // state B
							else
								next_state <= 2'b00;  // state A
						end
				end
				
				1: begin  // state B
					f <= 1'b1;
					g <= 1'b0;
					if (x)
						next_state <= 2'b10;  // state C
					else
						next_state <= 2'b00;  // state A
				end
				
				2: begin  // state C
					f <= 1'b0;
					if (y)
						g <= 1'b1;
					else
						g <= 1'b0;
					if (x)
						next_state <= 2'b10;  // state C
					else
						next_state <= 2'b00;  // state A
				end
				
				default: begin
					f <= 1'b0;
					g <= 1'b0;
					next_state <= 2'b00;  // state A
				end
			endcase
		end
	
endmodule
