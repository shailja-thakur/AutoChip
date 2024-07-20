module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [1:0] state;
	always @(posedge clk) begin
		if (~resetn) begin
			state <= 2'b0;
			f <= 1'b0;
			g <= 1'b0;
		end else begin
			case(state)
				2'b00: begin
					f <= 1'b0;
					if (x == 1'b1)
						state <= 2'b01;
				end
				2'b01: begin
					if (x == 1'b0)
						state <= 2'b10;
				end
				2'b10: begin
					if (x == 1'b1)
						state <= 2'b11;
				end
				2'b11: begin
					if (x == 1'b0)
						state <= 2'b00;
					else if (y == 1'b1)
						g <= 1'b1;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (~resetn)
			g <= 1'b0;
		else if (state == 2'b11 && g == 1'b1 && y == 1'b0)
			g <= 1'b0;
	end
endmodule
