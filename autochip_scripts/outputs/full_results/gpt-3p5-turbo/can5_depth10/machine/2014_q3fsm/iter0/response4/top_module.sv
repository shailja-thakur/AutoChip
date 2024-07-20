module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	// Define states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter S10 = 3;
	parameter S11 = 4;
	parameter S20 = 5;
	parameter S21 = 6;
	parameter S22 = 7;
	
	// Define current state reg
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (s) begin
						state <= B;
					end
				end
				
				B: begin
					if (w) begin
						state <= S11;
					end else begin
						state <= S10;
					end
				end
				
				C: begin
					if (w) begin
						state <= S11;
					end else begin
						state <= S10;
					end
				end
				
				S10: begin
					if (w) begin
						state <= S21;
					end else begin
						state <= S20;
					end
				end
				
				S11: begin
					if (w) begin
						state <= S22;
					end else begin
						state <= S21;
					end
				end
				
				S20: begin
					state <= B;
				end
				
				S21: begin
					if (w) begin
						state <= C;
					end else begin
						state <= B;
					end
				end
				
				S22: begin
					if (w) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			A: begin
				// Perform A state operations
			end
			
			B: begin
				// Perform B state operations
			end
			
			C: begin
				// Perform C state operations
			end
			
			S10: begin
				// Perform S10 state operations
			end
			
			S11: begin
				// Perform S11 state operations
			end
			
			S20: begin
				// Perform S20 state operations
			end
			
			S21: begin
				// Perform S21 state operations
			end
			
			S22: begin
				// Perform S22 state operations
			end
		endcase
	end
	
	assign z = (state == S20);
	
endmodule
