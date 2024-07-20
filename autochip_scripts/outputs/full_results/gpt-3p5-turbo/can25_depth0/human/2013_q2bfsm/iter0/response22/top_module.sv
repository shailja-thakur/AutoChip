module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [1:0] state, next_state;
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	// FSM state register
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	// FSM next state logic
	always @(state, x, y) begin
		case (state)
			A: begin
				if (resetn)
					next_state = (x == 1) ? B : A;
				else
					next_state = A;
			end
			
			B: begin
				if (resetn)
					next_state = (x == 0) ? C : A;
				else
					next_state = A;
			end
			
			C: begin
				if (resetn)
					next_state = (x == 1) ? D : A;
				else
					next_state = A;
			end
			
			D: begin
				if (resetn)
					next_state = (y == 1) ? D : A;
				else
					next_state = A;
			end
		endcase
	end
	
	// FSM outputs
	always @(state) begin
		case (state)
			A: begin
				f = 0;
				g = 0;
			end
			
			B: begin
				f = 1;
				g = 0;
			end
			
			C: begin
				f = 0;
				g = 0;
			end
			
			D: begin
				f = 0;
				g = 1;
			end
		endcase
	end
endmodule
