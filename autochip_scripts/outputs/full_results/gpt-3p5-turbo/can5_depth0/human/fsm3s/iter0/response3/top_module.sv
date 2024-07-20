module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

reg [1:0] state_reg, next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State transition logic
always @(posedge clk) begin
	if (reset) begin
		state_reg <= A;
	end else begin
		state_reg <= next_state;
	end
end

// Output logic
always @(state_reg, in) begin
	case (state_reg)
		A: out = 1'b0;
		B: out = 1'b0;
		C: out = 1'b0;
		D: out = 1'b1;
	endcase
	
	case (state_reg)
		A: begin
			if (in)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (in)
				next_state = B;
			else
				next_state = C;
		end
		C: begin
			if (in)
				next_state = D;
			else
				next_state = A;
		end
		D: begin
			if (in)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

endmodule
