module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

assign f = (state == 2'b00 && !resetn) ? 1 : 0;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

always @* begin
	next_state = state;
	case (state)
		2'b00:
			if (resetn) begin
				next_state = (x == 1) ? 2'b01 : 2'b00;
			end
		2'b01:
			if (resetn) begin
				next_state = (x == 0) ? 2'b10 : 2'b00;
			end
		2'b10:
			if (resetn) begin
				next_state = (x == 1 && g == 1) ? 2'b11 : 2'b00;
			end
		2'b11:
			if (resetn) begin
				if (y == 1) begin
					next_state = 2'b11;
					g = 1;
				end else begin
					next_state = 2'b00;
					g = 0;
				end
			end
	endcase
end

endmodule
