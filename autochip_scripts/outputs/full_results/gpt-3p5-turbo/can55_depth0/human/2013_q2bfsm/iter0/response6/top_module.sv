module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;
always @(posedge clk, negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00; // state A
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		2'b00: begin // state A
			f = 1'b0;
			if (x == 1'b1 && $past(x) == 1'b0 && $past($past(x)) == 1'b1) begin
				next_state = 2'b01; // state B
			end else begin
				next_state = 2'b00; // state A
			end
		end
		2'b01: begin // state B
			f = 1'b1;
			if (y == 1'b1) begin
				next_state = 2'b10; // state C
			end else begin
				next_state = 2'b01; // state B
			end
		end
		2'b10: begin // state C
			if (y == 1'b1) begin
				next_state = 2'b10; // state C
			end else begin
				next_state = 2'b11; // state D
			end
		end
		2'b11: begin // state D
			g = 1'b0;
			next_state = 2'b11; // state D
		end
	endcase
end

always @(posedge clk, negedge resetn) begin
	if (~resetn) begin
		f <= 1'b0;
	end else begin
		f <= f;
	end
end

always @(posedge clk, negedge resetn) begin
	if (~resetn) begin
		g <= 1'b0;
	end else begin
		g <= g;
	end
end

endmodule
