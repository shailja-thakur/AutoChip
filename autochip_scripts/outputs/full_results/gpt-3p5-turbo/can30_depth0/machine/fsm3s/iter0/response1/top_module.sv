module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @* begin
	case (state)
		2'b00: begin
			if (in)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		end
		2'b01: begin
			if (in)
				next_state = 2'b01;
			else
				next_state = 2'b10;
		end
		2'b10: begin
			if (in)
				next_state = 2'b11;
			else
				next_state = 2'b00;
		end
		2'b11: begin
			if (in)
				next_state = 2'b01;
			else
				next_state = 2'b10;
		end
	endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
