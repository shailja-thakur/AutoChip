module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	parameter state_A = 0;
	parameter state_B = 1;
	parameter state_C = 2;
	parameter state_S10 = 3;
	parameter state_S11 = 4;
	parameter state_S20 = 5;
	parameter state_S21 = 6;
	parameter state_S22 = 7;
	
	reg [3:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= state_A;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			state_A: begin
				if (s)
					next_state = state_B;
				else
					next_state = state_A;
			end
			
			state_B: begin
				if (w)
					next_state = state_S11;
				else
					next_state = state_S10;
			end
			
			state_C: begin
				if (w)
					next_state = state_S11;
				else
					next_state = state_S10;
			end
			
			state_S10: begin
				if (w)
					next_state = state_S21;
				else
					next_state = state_S20;
			end
			
			state_S11: begin
				if (w)
					next_state = state_S22;
				else
					next_state = state_S21;
			end
			
			state_S20: begin
				next_state = state_B;
			end
			
			state_S21: begin
				if (w)
					next_state = state_C;
				else
					next_state = state_B;
			end
			
			state_S22: begin
				if (w)
					next_state = state_B;
				else
					next_state = state_C;
			end
		endcase
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 0;
		else begin
			case (state)
				state_A: begin
					z <= 0;
				end
				
				state_B: begin
					z <= 0;
				end
				
				state_C: begin
					z <= 0;
				end
				
				state_S10: begin
					z <= 0;
				end
				
				state_S11: begin
					z <= 0;
				end
				
				state_S20: begin
					z <= 0;
				end
				
				state_S21: begin
					z <= 0;
				end
				
				state_S22: begin
					z <= 0;
				end
			endcase
		end
	end
	
endmodule
