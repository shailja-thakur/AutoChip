module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [1:0] state;
	reg f_reg, g_reg;
	wire x_r, x_f, y_r, y_f;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00;
			f_reg <= 0;
			g_reg <= 0;
		end else begin
			case (state)
				2'b00:
					if (resetn) begin
						state <= 2'b01;
						f_reg <= 0;
						g_reg <= 0;
					end
				2'b01:
					if (x) begin
						state <= 2'b10;
						f_reg <= 1;
						g_reg <= 0;
					end else
						f_reg <= 0;
				2'b10:
					if (x_r && x && x_f) begin
						state <= 2'b11;
						f_reg <= 0;
						g_reg <= 0;
					end else if (x)
						f_reg <= 1;
				2'b11:
					if (!y) begin
						state <= 2'b00;
						f_reg <= 0;
						g_reg <= 0;
					end else
						g_reg <= 1;
			endcase
		end
	end
	
	assign f = f_reg;
	assign g = g_reg;
	
	dff_edge dff_x (
		.clk(clk),
		.resetn(resetn),
		.d(x),
		.q(x_r),
		.qbar(x_f)
	);
	
	dff_edge dff_y (
		.clk(clk),
		.resetn(resetn),
		.d(y),
		.q(y_r),
		.qbar(y_f)
	);
	
endmodule
module dff_edge (
	input clk,
	input resetn,
	input d,
	output reg q,
	output reg qbar
);
	reg d_reg;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			d_reg <= 0;
		else
			d_reg <= d;
	end
	
	assign q = d_reg;
	assign qbar = ~d_reg;
	
endmodule
