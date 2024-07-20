module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [1:0] state;
	reg [2:0] x_sequence;
	reg [1:0] y_counter;

	// State encoding
	localparam STATE_A = 2'b00,
			   STATE_B = 2'b01,
			   STATE_C = 2'b10,
			   STATE_D = 2'b11;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= STATE_A;
			f <= 0;
			g <= 0;
			x_sequence <= 3'b000;
			y_counter <= 2'b00;
		end
		else begin
			case (state)
				STATE_A: begin
					f <= 1;
					state <= STATE_B;
				end

				STATE_B: begin
					f <= 0;
					x_sequence <= {x_sequence[1:0], x}; // shift in new x value
					if (x_sequence == 3'b101) begin
						g <= 1;
						state <= STATE_C;
					end
				end

				STATE_C: begin
					if (y) begin
						g <= 1;
						state <= STATE_D; // Stay permanently in STATE_D with g = 1
					end
					else begin
						y_counter <= y_counter + 1;
						if (y_counter == 2'b10) begin
							g <= 0;
							state <= STATE_D; // Stay permanently in STATE_D with g = 0
						end
					end
				end

				STATE_D: begin
					// Stay in this state permanently with g value as set previously
				end
			endcase
		end
	end
endmodule
