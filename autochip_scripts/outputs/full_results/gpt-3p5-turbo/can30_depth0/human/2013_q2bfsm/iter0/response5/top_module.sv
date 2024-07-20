module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;
reg f, g;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b0;
		f <= 1'b0;
		g <= 1'b0;
	end else begin
		state <= next_state;
		f <= 1'b0;
		g <= 1'b0;
	end
end

always @(*) begin
	case (state)
		2'b00: begin
			next_state = (resetn) ? 2'b01 : 2'b00;
			f = 1'b1;
			g = 1'b0;
		end
		2'b01: begin
			next_state = (resetn) ? 2'b10 : 2'b01;
			f = 1'b0;
			g = 1'b0;
		end
		2'b10: begin
			next_state = (x == 1'b1 && x == 1'b0 && x == 1'b1) ? 2'b11 : 2'b10;
			f = (state == 2'b10 && x == 1'b1 && x == 1'b0 && x == 1'b1) ? 1'b1 : 1'b0;
			g = 1'b0;
		end
		2'b11: begin
			next_state = (y == 1'b1) ? 2'b11 : 2'b10;
			f = 1'b0;
			g = (state == 2'b11 && y == 1'b1) ? 1'b1 : 1'b0;
		end
	endcase
end

endmodule
