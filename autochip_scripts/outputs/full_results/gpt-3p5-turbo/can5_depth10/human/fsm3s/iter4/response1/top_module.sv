module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	reg [1:0] state, next_state;
    
	always@(posedge clk or posedge reset) begin
		if(reset)
			state <= A;
		else
			state <= next_state;
	end
    
	always@(state, in) begin
		case(state)
			A: begin
			        out <= 1'b0;
				if(in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				out <= 1'b0;
				if(in)
					next_state = C;
				else
					next_state = B;
			end
			C: begin
				out <= 1'b0;
				if(in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				out <= 1'b1;
				if(in)
					next_state = B;
				else
					next_state = C;
			end
			default: begin
				out <= 1'b0;
				next_state = A;
			end
		endcase
	end

endmodule
