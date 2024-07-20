module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	always @(posedge clk or posedge reset) begin
		if(reset)
			state <= A;
		else
			state <= next_state;
	end
	
	always @* begin
		case(state)
			A: begin
				if(in)
					next_state = B;
				else
					next_state = A;
				out_reg = 1'b0;
			end
			B: begin
				if(in)
					next_state = C;
				else
					next_state = B;
				out_reg = 1'b0;
			end
			C: begin
				if(in)
					next_state = A;
				else
					next_state = D;
				out_reg = 1'b0;
			end
			D: begin
				if(in)
					next_state = C;
				else
					next_state = B;
				out_reg = 1'b1;
			end
		endcase
	end
	
	always @(posedge clk) begin
		out <= out_reg;
	end
	
endmodule
