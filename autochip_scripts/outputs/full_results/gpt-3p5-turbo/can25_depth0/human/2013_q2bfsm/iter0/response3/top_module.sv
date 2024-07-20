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
		if(~resetn) begin
			state <= 2'b0;
		end else begin
			state <= next_state;
		end
	end

	always @(state or x or y) begin
		case(state)
			2'b00: begin // state A
				f <= 1'b0;
				g <= 1'b0;
				if(x == 1'b1) begin
					next_state <= 2'b01;
				end else begin
					next_state <= 2'b00;
				end
			end

			2'b01: begin // state B
				f <= 1'b1;
				g <= 1'b0;
				if(x == 1'b0) begin
					next_state <= 2'b10;
				end else begin
					next_state <= 2'b01;
				end
			end

			2'b10: begin // state C
				f <= 1'b0;
				if(x == 1'b1) begin
					next_state <= 2'b11;
				end else begin
					next_state <= 2'b10;
				end
			end

			2'b11: begin // state D
				if(y == 1'b1) begin
					g <= 1'b1;
					next_state <= 2'b11;
				end else begin
					g <= 1'b0;
					next_state <= 2'b00;
				end
			end

			default: begin
				f <= 1'b0;
				g <= 1'b0;
				next_state <= 2'b00;
			end
		endcase
	end

endmodule
