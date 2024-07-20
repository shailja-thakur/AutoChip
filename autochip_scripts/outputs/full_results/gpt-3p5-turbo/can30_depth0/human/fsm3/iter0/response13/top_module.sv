module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	always @(posedge clk, posedge areset) begin
		if (areset) begin
			state <= A;
			out_reg <= 0;
		end else begin
			state <= next_state;
			out_reg <= (state == D) ? 1'b1 : 1'b0;
		end
	end
	
	always @(state, in) begin
		case(state)
			A: begin
				next_state <= (in == 1'b0) ? A : B;
			end
			B: begin
				next_state <= (in == 1'b0) ? C : B;
			end
			C: begin
				next_state <= (in == 1'b0) ? A : D;
			end
			D: begin
				next_state <= (in == 1'b0) ? C : B;
			end
		endcase
	end
	
	assign out = out_reg;
	
endmodule
