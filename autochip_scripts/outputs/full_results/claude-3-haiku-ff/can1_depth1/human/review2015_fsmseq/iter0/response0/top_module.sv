module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
reg [2:0] state, next_state;

always @(posedge clk) begin
	if (reset)
		state <= S0;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		S0: begin
			if (data == 1'b0)
				next_state = S1;
			else
				next_state = S0;
		end
		S1: begin
			if (data == 1'b1)
				next_state = S2;
			else
				next_state = S0;
		end
		S2: begin
			if (data == 1'b1)
				next_state = S3;
			else
				next_state = S0;
		end
		S3: begin
			if (data == 1'b0)
				next_state = S4;
			else
				next_state = S0;
		end
		S4: begin
			next_state = S4;
			start_shifting = 1'b1;
		end
		default:
			next_state = S0;
	endcase
end

endmodule
