module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [1:0] y_counter;

	localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(*) begin
		next_state = state;
		f = 0;
		case (state)
			A: begin
				f = 1;
				next_state = B;
			end
			B: begin
				if (x == 1'b1)
					next_state = C;
			end
			C: begin
				if (x == 1'b0)
					next_state = D;
			end
			D: begin
				if (x == 1'b1)
					next_state = E;
			end
			E: begin
				f = 0;
				if (g == 1'b1) begin
					if (y_counter < 2) begin
						if (y == 1'b1) 
							next_state = E;
					    else
							y_counter = y_counter + 1;
					end else 
						next_state = A;
				end else
					g = 1'b1;
			end
		endcase
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			g <= 1'b0;
			y_counter <= 2'b00;
		end else begin
			if (next_state == E && g == 1'b1) begin
				if (y == 1'b1)
					y_counter <= 2'b00;
				else if (y_counter < 2'b10)
					y_counter <= y_counter + 1;
				else
					g <= 1'b0;
			end
		end
	end
endmodule
