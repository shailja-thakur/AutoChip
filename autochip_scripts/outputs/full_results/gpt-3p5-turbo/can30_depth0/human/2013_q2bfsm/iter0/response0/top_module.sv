module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;
reg f_reg, g_reg;
reg [2:0] x_reg;
reg y_reg;
wire f, g;

always @(posedge clk, negedge resetn) begin
	if (resetn == 0) begin
		state <= 2'b00; // State A
		f_reg <= 0;
		g_reg <= 0;
		x_reg <= 0;
		y_reg <= 0;
	end else begin
		state <= next_state;
		f_reg <= f;
		g_reg <= g;
		x_reg <= {x_reg[1:0], x};
		y_reg <= y;
	end
end


always @* begin
	case (state)
		0: begin // State A
			if (resetn == 0)
				next_state = 0;
			else
				next_state = 1;
		end
		1: begin // State B
			next_state = 2;
		end
		2: begin // State C
			if (x_reg == 3'b101)
				next_state = 3;
			else
				next_state = 2;
		end
		3: begin // State D
			if (y_reg == 1)
				next_state = 4;
			else
				next_state = 5;
		end
		4: begin // State E
			next_state = 4;
		end
		5: begin // State F
			next_state = 5;
		end
		default: begin
			next_state = 0;
		end
	endcase
end


assign f = (state == 1) ? 1 : 0;
assign g = g_reg;

endmodule
