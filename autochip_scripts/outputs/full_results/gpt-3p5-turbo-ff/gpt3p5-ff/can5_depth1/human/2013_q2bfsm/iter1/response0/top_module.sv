module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [2:0] state;
reg [2:0] state_next;
reg f_reg;
reg g_reg;
reg f_next;
reg g_next;

always @(posedge clk or negedge resetn)
begin
	if (~resetn)
	begin
		state <= 3'b000;
		f_reg <= 1'b0;
		g_reg <= 1'b0;
	end
	else
	begin
		state <= state_next;
		f_reg <= f_next;
		g_reg <= g_next;
	end
end

always @*
begin
	state_next = state;
	f_next = f_reg;
	g_next = g_reg;
	
	case (state)
		3'b000: // State A
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else if (x == 1)
				state_next = 3'b001;
		end
		
		3'b001: // State B
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else if (x == 0)
				state_next = 3'b010;
			else if (x == 1)
			begin
				f_next = 1'b1;
				state_next = 3'b011;
			end
		end
		
		3'b010: // State C
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else if (x == 1)
				state_next = 3'b011;
			else if (x == 0)
			begin
				f_next = 1'b0;
				state_next = 3'b010;
			end
		end
		
		3'b011: // State D
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else if (x == 1)
				state_next = 3'b100;
			else if (x == 0)
				state_next = 3'b010;
		end
		
		3'b100: // State E
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else if (y == 1)
			begin
				g_next = 1'b1;
				state_next = 3'b101;
			end
			else if (y == 0)
			begin
				g_next = 1'b0;
				state_next = 3'b110;
			end
		end
		
		3'b101: // State F
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else if (y == 1)
				state_next = 3'b101;
			else if (y == 0)
				state_next = 3'b110;
		end
		
		3'b110: // State G
		begin
			if (~resetn)
			begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 3'b000;
			end
			else
				state_next = 3'b110;
		end
	endcase
end

always @(posedge clk)
begin
	f <= f_reg;
	g <= g_reg;
end

endmodule
