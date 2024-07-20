module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case(state)
		2'b00: begin
			if (~resetn) begin
				next_state = 2'b00;
				f = 1'b0;
				g = 1'b0;
			end else begin
				next_state = 2'b01;
				f = 1'b1;
				g = 1'b0;
			end
		end

		2'b01: begin
			if (x == 1'b1) begin
				next_state = 2'b10;
				f = 1'b0;
				g = 1'b0;
			end else begin
				next_state = 2'b01;
				f = 1'b0;
				g = 1'b0;
			end
		end

		2'b10: begin
			if (x == 1'b0) begin
				next_state = 2'b11;
				f = 1'b0;
				g = 1'b0;
			end else begin
				next_state = 2'b10;
				f = 1'b0;
				g = 1'b0;
			end
		end

		2'b11: begin
			if (x == 1'b1) begin
				if (y == 1'b1) begin
					next_state = 2'b11;
					f = 1'b0;
					g = 1'b1;
				end else begin
					if (y == 1'b0) begin
						next_state = 2'b00;
						f = 1'b0;
						g = 1'b0;
					end else begin
						next_state = 2'b11;
						f = 1'b0;
						g = 1'b0;
					end
				end
			end else begin
				next_state = 2'b11;
				f = 1'b0;
				g = 1'b0;
			end
		end

		default: begin
			next_state = 2'b00;
			f = 1'b0;
			g = 1'b0;
		end
	endcase
end
endmodule
