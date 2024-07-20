module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f, g;
reg [1:0] state, next_state;
reg [2:0] x_history;
reg [1:0] y_counter;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b00;
		f <= 1'b0;
		g <= 1'b0;
		x_history <= 3'b000;
		y_counter <= 2'b00;
	end else begin
		state <= next_state;
		f <= 1'b0;
		g <= 1'b0;
		x_history <= {x_history[1:0], x};
		y_counter <= y_counter + 1'b1;
	end
end

always_comb begin
	case (state)
		2'b00: begin // State A
			if (!resetn)
				next_state = 2'b00;
			else if (x_history == 3'b101)
				next_state = 2'b01;
			else
				next_state = 2'b00;
			f = 1'b0;
			g = 1'b0;
		end
		2'b01: begin // State B
			if (resetn)
				next_state = 2'b10;
			else
				next_state = 2'b00;
			f = 1'b1;
			g = 1'b0;
		end
		2'b10: begin // State C
			if (resetn)
				next_state = 2'b10;
			else if (y == 1'b1)
				next_state = 2'b11;
			else if (y_counter >= 2'b10)
				next_state = 2'b00;
			else
				next_state = 2'b10;
			f = 1'b0;
			g = 1'b1;
		end
		2'b11: begin // State D
			if (resetn)
				next_state = 2'b10;
			else
				next_state = 2'b11;
			f = 1'b0;
			g = 1'b1;
		end
	endcase
end

endmodule
