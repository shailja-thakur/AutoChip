module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state;
reg f;
reg g;

always @(posedge clk or negedge resetn) begin
	if(~resetn) begin
		state <= 2'b00;
		f <= 0;
		g <= 0;
	end else begin
		case (state)
			2'b00:
				if (x == 1'b1 && y == 1'b0) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			2'b01:
				if (x == 1'b0 && y == 1'b1) begin
					f <= 1;
					state <= 2'b10;
				end else begin
					state <= 2'b01;
				end
			2'b10:
				if (x == 1'b1 && y == 1'b1) begin
					state <= 2'b10;
					g <= 1;
				end else if (x == 1'b0 && y == 1'b1) begin
					state <= 2'b10;
					g <= 0;
				end else begin
					state <= 2'b11;
					g <= 0;
				end
			2'b11:
				state <= 2'b00;
				f <= 0;
				g <= 0;
		endcase
	end
end

endmodule
