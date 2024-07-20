module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state;
reg f, g;
reg [2:0] x_history;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b0;
		f <= 1'b0;
		g <= 1'b0;
		x_history <= 3'b000;
	end else begin
		case(state)
			2'b00: begin // State A
				if (resetn == 0) begin
					state <= 2'b00;
					f <= 1'b0;
					g <= 1'b0;
					x_history <= 3'b000;
				end else begin
					state <= 2'b01;
					f <= 1'b0;
				end
			end
			2'b01: begin // State B
				if (resetn == 0) begin
					state <= 2'b00;
					f <= 1'b0;
					g <= 1'b0;
					x_history <= 3'b000;
				end else if (x == 1) begin
					state <= 2'b10;
					g <= 1'b0;
				end else begin
					state <= 2'b01;
					x_history <= {x_history[1:0], x};
					f <= 1'b1;
				end
			end
			2'b10: begin // State C
				if (resetn == 0) begin
					state <= 2'b00;
					f <= 1'b0;
					g <= 1'b0;
					x_history <= 3'b000;
				end else begin
					state <= 2'b11;
					g <= 1'b0;
				end
			end
			2'b11: begin // State D
				if (resetn == 0) begin
					state <= 2'b00;
					f <= 1'b0;
					g <= 1'b0;
					x_history <= 3'b000;
				end else if (y == 1) begin
					state <= 2'b11;
					g <= 1'b1;
				end else if (x_history == 3'b101) begin
					state <= 2'b10;
					g <= 1'b1;
				end else begin
					state <= 2'b11;
					x_history <= {x_history[1:0], x};
					g <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
