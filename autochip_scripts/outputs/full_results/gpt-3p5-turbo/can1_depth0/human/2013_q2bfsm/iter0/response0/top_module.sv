module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [2:0] state;
reg f_reg, g_reg;
reg g_permanent;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 3'b000;
		f_reg <= 1'b0;
		g_reg <= 1'b0;
		g_permanent <= 1'b0;
	end
	
	else begin
		case (state)
			3'b000:
				begin
					if (resetn) begin
						f_reg <= 1'b1;
						state <= 3'b001;
					end
				end
			
			3'b001:
				begin
					if (x == 1'b1) begin
						state <= 3'b010;
					end
				end
			
			3'b010:
				begin
					if (x == 1'b0) begin
						state <= 3'b011;
					end
				end
			
			3'b011:
				begin
					if (x == 1'b1) begin
						state <= 3'b100;
						g_reg <= 1'b1;
					end
				end
			
			3'b100:
				begin
					if (y == 1'b1) begin
						g_permanent <= 1'b1;
						state <= 3'b100;
					end
					
					else begin
						if (g_permanent & (y != 1'b1)) begin
							g_permanent <= 1'b0;
							g_reg <= 1'b0;
						end
						
						else begin
							g_reg <= 1'b1;
						end
					end
				end
		endcase
	end
end

assign f = f_reg;
assign g = g_reg;

endmodule
