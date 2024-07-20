module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [2:0] state;

always @(posedge clk or negedge resetn)
begin
	if (~resetn)
	begin
		state <= 3'b000;
		f <= 1'b0;
		g <= 1'b0;
	end
	else
	begin
		case (state)
			3'b000: // State A
			begin
				if (x == 1)
					state <= 3'b001;
			end
			
			3'b001: // State B
			begin
				if (x == 0)
					state <= 3'b010;
				else if (x == 1)
				begin
					f <= 1'b1;
					state <= 3'b011;
				end
			end
			
			3'b010: // State C
			begin
				if (x == 1)
					state <= 3'b011;
				else if (x == 0)
				begin
					f <= 1'b0;
					state <= 3'b010;
				end
			end
			
			3'b011: // State D
			begin
				if (x == 1)
					state <= 3'b100;
				else if (x == 0)
					state <= 3'b010;
			end
			
			3'b100: // State E
			begin
				if (y == 1)
				begin
					g <= 1'b1;
					state <= 3'b101;
				end
				else if (y == 0)
				begin
					g <= 1'b0;
					state <= 3'b110;
				end
			end
			
			3'b101: // State F
			begin
				if (y == 1)
					state <= 3'b101;
				else if (y == 0)
					state <= 3'b110;
			end
			
			3'b110: // State G
			begin
				state <= 3'b110;
			end
		endcase
	end
end

endmodule
