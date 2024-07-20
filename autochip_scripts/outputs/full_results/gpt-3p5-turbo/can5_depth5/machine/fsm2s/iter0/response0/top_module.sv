module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @* begin
	case (state)
		2'b00:
			if (j)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		2'b01:
			if (k)
				next_state = 2'b00;
			else
				next_state = 2'b01;
	endcase
end

assign out = (state == 2'b01);

endmodule
