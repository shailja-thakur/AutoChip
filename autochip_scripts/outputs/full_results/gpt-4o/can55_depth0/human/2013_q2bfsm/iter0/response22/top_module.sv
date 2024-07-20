module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [2:0] x_history;
	reg [1:0] y_counter;
	
	localparam A = 3'b000,
	           B = 3'b001,
	           C = 3'b010,
	           D = 3'b011,
	           E = 3'b100,
	           F = 3'b101,
	           G = 3'b110;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
			x_history <= 3'b000;
			y_counter <= 2'b00;
		end else begin
			case (state)
				A: begin
					f <= 0;
					g <= 0;
					x_history <= 3'b000;
					y_counter <= 2'b00;
					if (resetn)
						next_state <= B;
					else
						next_state <= A;
				end
				
				B: begin
					f <= 1;
					next_state <= C;
					g <= 0;
					x_history <= x_history;
					y_counter <= y_counter;
				end
				
				C: begin
					f <= 0;
					x_history <= {x_history[1:0], x};
					if (x_history == 3'b101)
						next_state <= D;
					else
						next_state <= C;
				end
				
				D: begin
					g <= 1;
					next_state <= E;
				end

				E: begin
					y_counter <= y_counter + 1;
					if (y_counter < 2'b10 && y == 1) begin
						g <= 1;
						next_state <= G;
					end else if (y_counter == 2'b10) begin
						g <= 0;
						next_state <= F;
					end else begin
						next_state <= E;
					end
				end
				
				F: begin
					g <= 0;
				end
				
				G: begin
					g <= 1;
				end
				
				default: next_state <= A;
			endcase
		end
	end

endmodule
