module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [1:0] state;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // state A
			f <= 0;
			g <= 0;
		end else begin
			case (state)
				2'b00: begin // state A
					if (resetn) begin
						f <= 0;
						g <= 0;
						state <= 2'b01; // transition to next state
					end
				end
				2'b01: begin // state B
					if (x == 1'b1) begin
						state <= 2'b10; // transition to next state
					end
				end
				2'b10: begin // state C
					if (x == 1'b0) begin
						state <= 2'b11; // transition to next state
					end
				end
				2'b11: begin // state D
					if (x == 1'b1) begin
						f <= 1;
						state <= 2'b00; // transition to initial state
					end
				end
			endcase
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			g <= 0;
		end else begin
			case (state)
				2'b00: begin // state A
					if (resetn) begin
						g <= 0;
					end
				end
				2'b10: begin // state C
					if (y == 1'b1) begin
						g <= 1;
					end else begin
						g <= 0;
					end
				end
				2'b11: begin // state D
					if (y == 1'b1) begin
						g <= 1;
					end
				end
			endcase
		end
	end

endmodule
