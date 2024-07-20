module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f;
reg g;
reg [1:0] state;
reg [2:0] x_history;
reg [1:0] y_history;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b0;
		f <= 1'b0;
		g <= 1'b0;
	end else begin
		case (state)
			0: begin // State A
				if (resetn) begin
					state <= 1'b1;
					f <= 1'b0;
				end
			end
			1: begin // State B
				f <= 1'b1;
				if (x == 1'b1) begin
					state <= 1'b0;
				end
			end
			2: begin // State C
				if (x == 1'b0) begin
					state <= 1'b3;
				end
			end
			3: begin // State D
				if (x == 1'b1) begin
					state <= 1'b4;
				end
			end
			4: begin // State E
				g <= 1'b1;
				if (y == 1'b1) begin
					state <= 1'b5;
				end else if (y_history == 2'b00) begin
					state <= 1'b6;
				end
			end
			5: begin // State F
				if (y == 1'b0) begin
					state <= 1'b7;
				end
			end
			6: begin // State G
				if (y == 1'b1) begin
					state <= 1'b6;
				end else if (y_history == 2'b00) begin
					state <= 1'b7;
				end
			end
			7: begin // State H
				g <= 1'b0;
				if (resetn) begin
					state <= 1'b1;
				end
			end
			default: begin
				state <= 1'b0;
				f <= 1'b0;
				g <= 1'b0;
			end
		endcase
	end
end

always @(posedge clk) begin
	x_history <= {x_history[0], x};
	y_history <= {y_history[0], y};
end

assign f = f;
assign g = g;

endmodule
