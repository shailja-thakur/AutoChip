module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	// Declare the 4 states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Declare the state register
	reg [1:0] state_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= A;
		end else begin
			case (state_reg)
				A: begin
					if (in) begin
						state_reg <= B;
					end else begin
						state_reg <= A;
					end
				end
				
				B: begin
					if (in) begin
						state_reg <= B;
					end else begin
						state_reg <= C;
					end
				end
				
				C: begin
					if (in) begin
						state_reg <= D;
					end else begin
						state_reg <= A;
					end
				end
				
				D: begin
					if (in) begin
						state_reg <= B;
					end else begin
						state_reg <= C;
					end
				end
			endcase
		end
	end
	
	// Output assignment
	assign out = (state_reg == D) ? 1'b1 : 1'b0;
	
endmodule
