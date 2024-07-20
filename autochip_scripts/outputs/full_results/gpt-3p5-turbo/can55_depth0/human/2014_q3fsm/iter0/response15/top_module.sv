module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @* begin
	case (state)
		2'b00:
		begin
			if (s)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		end
		2'b01:
		begin
			if (w == 2'b11)
				next_state = 2'b10;
			else
				next_state = 2'b01;
		end
		2'b10:
		begin
			if (w == 2'b01 || w == 2'b10 || w == 2'b11)
				next_state = 2'b11;
			else if (w == 2'b00)
				next_state = 2'b00;
		end
		2'b11:
		begin
			if (w == 2'b00 || w == 2'b01 || w == 2'b10)
				next_state = 2'b00;
			else if (w == 2'b11)
				next_state = 2'b01;
		end
		default:
		begin
			next_state = 2'b00;
		end
	endcase
end

always @(posedge clk) begin
	if (state == 2'b10)
		z <= 1'b1;
	else
		z <= 1'b0;
end

endmodule
