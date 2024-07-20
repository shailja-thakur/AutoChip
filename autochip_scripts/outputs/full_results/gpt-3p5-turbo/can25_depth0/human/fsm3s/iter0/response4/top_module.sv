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
	
	reg [1:0] current_state, next_state;
	reg out_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
			out_reg <= 0;
		end else begin
			current_state <= next_state;
			out_reg <= (current_state == D) ? 1'b1 : 1'b0;
		end
	end
	
	always @(current_state, in) begin
		case (current_state)
			A: next_state = (in == 1'b0) ? A : B;
			B: next_state = (in == 1'b0) ? C : B;
			C: next_state = (in == 1'b0) ? A : D;
			D: next_state = (in == 1'b0) ? C : B;
		endcase
	end
	
	assign out = out_reg;
endmodule
