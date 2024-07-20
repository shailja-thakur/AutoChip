module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [1:0] state, next_state;
	reg f_reg, g_reg;

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
			f_reg <= 0;
			g_reg <= 0;
		end else begin
			state <= next_state;
			f_reg <= (state == B) ? 1'b1 : 1'b0;
			g_reg <= (state == C) ? 1'b1 :
						((state == A) && (y == 1'b1)) ? 1'b0 : g_reg;
		end
	end

	always @(state, x) begin
		case(state)
			A: begin
				next_state = (x == 1'b1) ? B : A;
			end
			B: begin
				next_state = (x == 1'b0) ? A : B;
			end
			C: begin
				next_state = A;
			end
		endcase
	end

	assign f = f_reg;
	assign g = g_reg;

endmodule
