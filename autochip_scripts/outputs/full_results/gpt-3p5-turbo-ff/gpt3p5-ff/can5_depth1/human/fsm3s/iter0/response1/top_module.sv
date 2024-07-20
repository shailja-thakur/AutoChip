module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	reg out_reg;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
		
		case(state)
			A: 
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
				
				out_reg = 1'b0;
			
			B:
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				
				out_reg = 1'b0;
				
			C:
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
				
				out_reg = 1'b0;
				
			D:
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				
				out_reg = 1'b1;
		endcase
	end
	
	always @(posedge clk) begin
		out <= out_reg;
	end
	
endmodule
