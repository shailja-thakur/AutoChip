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
	
	// FSM state assignments
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	
	always @(*) begin
		case (state)
			A: begin
				if (resetn == 1'b0)
					next_state = A;
				else
					next_state = (x == 1'b1) ? B : A;
			end
		
			B: begin
				if (resetn == 1'b0)
					next_state = A;
				else
					next_state = (x == 1'b0) ? C : B;
			end
			
			C: begin
				if (resetn == 1'b0)
					next_state = A;
				else
					next_state = (x == 1'b1) ? C : B;
			end
		endcase
	end
	
	// FSM output assignments
	always @(state or resetn) begin
		case (state)
			A: begin
				f = 1'b0;
				g = 1'b0;
			end
			
			B: begin
				f = 1'b1;
				g = 1'b0;
			end
			
			C: begin
				f = 1'b0;
				g = 1'b1;
			end
		endcase
	end
endmodule
