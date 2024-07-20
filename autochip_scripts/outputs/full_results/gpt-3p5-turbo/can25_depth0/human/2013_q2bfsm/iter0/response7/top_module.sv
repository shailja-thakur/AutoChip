module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [1:0] state, next_state;
	always @(posedge clk, negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00;
		end else begin
			state <= next_state;
		end
	end

	reg f_reg, g_reg;
	always @(posedge clk) begin
		f_reg <= 1'b0;
		g_reg <= 1'b0;
		case (state)
			2'b00: begin // State A
				if (!resetn) begin
					next_state <= 2'b00;
				end else if (x == 1'b1 && y == 1'b0) begin
					next_state <= 2'b01;
					f_reg <= 1'b1;
				end else begin
					next_state <= 2'b00;
				end
			end

			2'b01: begin // State B
				if (x == 1'b0) begin
					next_state <= 2'b10;
				end else begin
					next_state <= 2'b01;
				end
			end

			2'b10: begin // State C
				if (x == 1'b1) begin
					next_state <= 2'b11;
				end else begin
					next_state <= 2'b10;
				end
			end

			2'b11: begin // State D
				if (x == 1'b0) begin
					next_state <= 2'b00;
				end else begin
					next_state <= 2'b11;
				end
			end

			default: next_state <= 2'b00;
		endcase

		if (state == 2'b10 && x == 1'b1 && y == 1'b1) begin
			g_reg <= 1'b1;
		end else if (state == 2'b11 && y == 1'b1) begin
			g_reg <= 1'b1;
		end else begin
			g_reg <= 1'b0;
		end
	end

	assign f = f_reg;
	assign g = g_reg;
endmodule
