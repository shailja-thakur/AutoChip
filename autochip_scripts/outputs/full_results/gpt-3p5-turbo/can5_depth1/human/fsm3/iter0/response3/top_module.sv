module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
reg out_reg;
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00; // Reset state to A
	else
		state <= next_state;
end

always @(state, in) begin
	case (state)
		2'b00: begin
			if (in)
				next_state = 2'b10; // Next state is B
			else
				next_state = 2'b01; // Next state is A
			out_reg = 1'b0;
		end
		2'b01: begin
			if (in)
				next_state = 2'b10; // Next state is B
			else
				next_state = 2'b11; // Next state is C
			out_reg = 1'b0;
		end
		2'b10: begin
			if (in)
				next_state = 2'b01; // Next state is A
			else
				next_state = 2'b11; // Next state is C
			out_reg = 1'b0;
		end
		2'b11: begin
			if (in)
				next_state = 2'b01; // Next state is A
			else
				next_state = 2'b10; // Next state is D
			out_reg = 1'b1;
		end
	endcase
end

always @(posedge clk) begin
	out <= out_reg;
end

endmodule
