module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk, posedge reset) begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @* begin
	case (state)
		2'b00: begin
			if (s == 1)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		end
		2'b01: begin
			if ((w == 1) + (w == 1) + (w == 1) == 2)
				next_state = 2'b10;
			else
				next_state = 2'b00;
		end
		2'b10: begin
			next_state = 2'b00;
		end
		default: next_state = 2'b00;
	endcase
end

always @(posedge clk) begin
	if (state == 2'b10)
		z <= 1;
	else
		z <= 0;
end

endmodule
