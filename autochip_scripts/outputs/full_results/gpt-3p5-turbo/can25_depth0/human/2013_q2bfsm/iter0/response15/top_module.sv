module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f, g;
reg [1:0] state;
reg [2:0] x_history;
wire clk_edge;

assign clk_edge = ~clk & $past(clk);

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00;
		x_history <= 3'b000;
		f <= 1'b0;
		g <= 1'b0;
	end else begin
		case (state)
			2'b00: begin // State A
				f <= 1'b0;
				g <= 1'b0;
				if (clk_edge) begin
					state <= 2'b01;
				end
			end
			2'b01: begin // State B
				f <= 1'b1;
				state <= 2'b10;
			end
			2'b10: begin // State C
				if (x_history == 3'b101) begin
					g <= 1'b1;
					state <= 2'b11;
				end
				x_history <= {x_history[1:0], x};
			end
			2'b11: begin // State D
				if (y) begin
					g <= 1'b1;
				end else begin
					g <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
