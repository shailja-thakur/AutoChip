module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] current_state, next_state;
reg out_reg;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

always @(current_state, in) begin
	case (current_state)
		A: begin
			if (in)
				next_state <= B;
			else
				next_state <= A;
		end

		B: begin
			if (in)
				next_state <= B;
			else
				next_state <= C;
		end

		C: begin
			if (in)
				next_state <= D;
			else
				next_state <= A;
		end

		D: begin
			if (in)
				next_state <= B;
			else
				next_state <= C;
		end
	endcase
end

always @(current_state) begin
	case (current_state)
		A: out_reg = 0;
		B: out_reg = 0;
		C: out_reg = 0;
		D: out_reg = 1;
	endcase
end

assign out = out_reg;
endmodule
