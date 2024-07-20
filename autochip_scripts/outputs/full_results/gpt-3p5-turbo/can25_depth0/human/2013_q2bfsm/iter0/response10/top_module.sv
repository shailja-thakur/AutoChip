module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [1:0] state;
	reg g_permanent;
	reg g_temporary;
	
	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			state <= 2'b00;
		else
		begin
			case(state)
				2'b00:  // State A
				begin
					if (!resetn)
						state <= 2'b00;
					else if (x == 1'b1)
						state <= 2'b01;
				end
				
				2'b01:  // State B
				begin
					if (x == 1'b0)
						state <= 2'b10;
				end
				
				2'b10:  // State C
				begin
					if (x == 1'b1)
					begin
						state <= 2'b11;
						f <= 1'b1;
					end
						
					else if (y == 1'b1)
					begin
						state <= 2'b00;
						g_permanent <= 1'b1;
					end
						
				end
				
				2'b11:  // State D
				begin
					if (x == 1'b0)
						state <= 2'b00;
						
					else if (y == 1'b1)
						g_permanent <= 1'b1;
					
					else
						state <= 2'b10;
				end
			endcase
		end
	end
	
	always @(negedge resetn)
	begin
		if (!resetn)
		begin
			g_permanent <= 1'b0;
			f <= 1'b0;
		end
	end
	
	assign g = g_permanent;
	
endmodule
