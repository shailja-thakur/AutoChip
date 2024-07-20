module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [1:0] x_seq;
	
	parameter A = 3'b000,
	          B = 3'b001,
	          C = 3'b010,
	          D = 3'b011,
	          E = 3'b100,
	          F = 3'b101;
	          
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			A: begin
				f = 0;
				g = 0;
				if (!resetn)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				f = 1;
				g = 0;
				next_state = C;
			end
			C: begin
				f = 0;
				if (x_seq == 2'b101)
					next_state = D;
				else
					next_state = C;
			end
			D: begin
				f = 0;
				g = 1;
				if (y)
					next_state = E;
				else
					next_state = F;
			end
			E: begin
				f = 0;
				g = 1;
				next_state = E;
			end
			F: begin
				f = 0;
				g = 0;
				next_state = F;
			end
			default: begin
				next_state = A;
			end
		endcase
	end
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			x_seq <= 2'b0;
		end else begin
			if (state == B || state == C) begin
				x_seq <= {x_seq[0], x};
			end
		end
	end
endmodule
