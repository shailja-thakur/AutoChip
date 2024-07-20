module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state, next_state;
reg out;

always @(posedge clk, posedge reset)
begin
	if (reset)
		state <= 2'b0;
	else
		state <= next_state;
end

always @*
begin
	case (state)
		2'b00: begin
			out <= 1'b0;
			if (j)
				next_state = 2'b1;
			else
				next_state = 2'b0;
		end
		2'b01: begin
			out <= 1'b0;
			if (k)
				next_state = 2'b0;
			else
				next_state = 2'b1;
		end
		2'b10: begin
			out <= 1'b1;
			if (k)
				next_state = 2'b0;
			else
				next_state = 2'b1;
		end
		2'b11: begin
			out <= 1'b1;
			if (j)
				next_state = 2'b1;
			else
				next_state = 2'b0;
		end
	endcase
end

endmodule
