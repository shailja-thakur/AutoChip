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

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00;
		x_history <= 3'b000;
		f <= 1'b0;
		g <= 1'b0;
	end else begin
		case (state)
			2'b00: begin
				if (x == 1'b1) begin
					state <= 2'b01;
					f <= 1'b0;
				end
			end
			2'b01: begin
				x_history[2:1] <= x_history[1:0];
				x_history[0] <= x;
				if (x_history == 3'b101) begin
					state <= 2'b10;
				end
				if (x == 1'b1) begin
					state <= 2'b00;
					f <= 1'b1;
				end
			end
			2'b10: begin
				if (y == 1'b1) begin
					state <= 2'b11;
					g <= 1'b1;
				end else if (y != 1'b1) begin
					state <= 2'b00;
					f <= 1'b1;
				end
			end
			2'b11: begin
				if (y != 1'b1) begin
					state <= 2'b00;
					f <= 1'b1;
					g <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
