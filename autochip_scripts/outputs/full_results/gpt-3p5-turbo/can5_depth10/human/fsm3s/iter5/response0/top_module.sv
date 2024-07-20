module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	reg [1:0] state, next_state;
    
	always @(posedge clk) begin
		if(reset)
			state <= A;
		else
			state <= next_state;
	end
    
	always @(state, in) begin
		case(state)
			A: begin
				if(in)
					next_state <= B;
				else
					next_state <= A;
			end
			B: begin
				if(in)
					next_state <= B;
				else
					next_state <= C;
			end
			C: begin
				if(in)
					next_state <= D;
				else
					next_state <= A;
			end
			D: begin
				if(in)
					next_state <= B;
				else
					next_state <= C;
			end
			default: begin
				next_state <= A;
			end
		endcase
	end
    
	always@(state) begin
		case(state)
			A : out <= 1'b0;
			D : out <= 1'b1;
			default : out <= 1'b0;
		endcase
	end

endmodule
