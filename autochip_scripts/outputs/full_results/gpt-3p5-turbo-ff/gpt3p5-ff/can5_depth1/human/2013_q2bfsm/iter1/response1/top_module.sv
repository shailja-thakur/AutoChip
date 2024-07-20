module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [2:0] state;
reg [2:0] prev_x;
reg [1:0] prev_y;

always @(posedge clk or negedge resetn)
begin
	if (~resetn)
	begin
		state <= 3'b000;
		f <= 1'b0;
		g <= 1'b0;
		prev_x <= 3'b000;
		prev_y <= 2'b00;
	end
	else
	begin
		case (state)
			3'b000: // State A
			begin
				if (resetn == 1'b0)
				begin
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
				begin
					if (x == 1'b1)
						state <= 3'b001;
				end
			end
			
			3'b001: // State B
			begin
				if (resetn == 1'b0)
				begin
					state <= 3'b000;
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
				begin
					if (x == 1'b0)
						state <= 3'b010;
					else if (x == 1'b1)
					begin
						f <= 1'b1;
						state <= 3'b011;
					end
				end
			end
			
			3'b010: // State C
			begin
				if (resetn == 1'b0)
				begin
					state <= 3'b000;
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
				begin
					if (x == 1'b1)
						state <= 3'b011;
					else if (x == 1'b0)
					begin
						f <= 1'b0;
						state <= 3'b010;
					end
				end
			end
			
			3'b011: // State D
			begin
				if (resetn == 1'b0)
				begin
					state <= 3'b000;
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
				begin
					if (x == 1'b0)
						state <= 3'b010;
					else if (x == 1'b1)
						state <= 3'b100;
				end
			end
			
			3'b100: // State E
			begin
				if (resetn == 1'b0)
				begin
					state <= 3'b000;
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
				begin
					if (prev_x == 3'b101 && prev_y == 2'b01)
					begin
						if (y == 1'b1)
						begin
							g <= 1'b1;
							state <= 3'b101;
						end
						else
						begin
							g <= 1'b0;
							state <= 3'b110;
						end
					end
					else
					begin
						prev_x <= x;
						prev_y <= y;
						state <= 3'b100;
					end
				end
			end
			
			3'b101: // State F
			begin
				if (resetn == 1'b0)
				begin
					state <= 3'b000;
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
				begin
					if (y == 1'b1)
						state <= 3'b101;
					else if (y == 1'b0)
						state <= 3'b110;
				end
			end
			
			3'b110: // State G
			begin
				if (resetn == 1'b0)
				begin
					state <= 3'b000;
					f <= 1'b0;
					g <= 1'b0;
				end
				if (resetn == 1'b1)
					state <= 3'b110;
			end
		endcase
	end
end

endmodule
