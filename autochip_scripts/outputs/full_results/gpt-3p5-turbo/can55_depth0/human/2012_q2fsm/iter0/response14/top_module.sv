module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= A;
		end
		else begin
			state <= next_state;
		end
	end
	
	always @(state, w) begin
		case(state)
			A: begin
				if (w) begin
					next_state = B;
				end
				else begin
					next_state = A;
				end
			end
		
			B: begin
				if (w) begin
					next_state = C;
				end
				else begin
					next_state = D;
				end
			end

			C: begin
				if (w) begin
					next_state = E;
				end
				else begin
					next_state = D;
				end
			end

			D: begin
				if (w) begin
					next_state = F;
				end
				else begin
					next_state = A;
				end
			end
			
			E: begin
				if (w) begin
					next_state = E;
				end
				else begin
					next_state = D;
				end
			end
			
			F: begin
				if (w) begin
					next_state = C;
				end
				else begin
					next_state = D;
				end
			end
			
			default: next_state = A;
		endcase
	end
	
	assign z = (state == E || state == F) ? 1'b1 : 1'b0;
	
endmodule
