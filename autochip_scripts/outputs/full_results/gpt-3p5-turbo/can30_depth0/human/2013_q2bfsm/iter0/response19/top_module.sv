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

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		f <= 0;
		g <= 0;
		state <= 0;
	end else begin
		case(state)
			2'b00: begin
				f <= 1;
				state <= 2'b01;
			end
			2'b01: begin
				if (x == 1) begin
					state <= 2'b10;
				end else begin
					state <= 2'b01;
				end
			end
			2'b10: begin
				if (x == 0) begin
					state <= 2'b11;
				end else begin
					state <= 2'b10;
				end
			end
			2'b11: begin
				if (x == 1) begin
					state <= 2'b00;
					g <= 1;
				end else begin
					state <= 2'b11;
				end
			end
		endcase
	end
end

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		g <= 0;
	end else begin
		if (state == 2'b11) begin
			if (y == 1) begin
				g <= 1;
			end else begin
				g <= 0;
			end
		end
	end
end

endmodule
