module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state;

always @(posedge clk)
begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @(*)
begin
	case(state)
		2'b00: begin
			next_state = (s == 1) ? 2'b01 : 2'b00;
		end
		
		2'b01: begin
			next_state = (w == 1) ? 2'b10 : 2'b00;
		end
		
		2'b10: begin
			next_state = (w == 1) ? 2'b11 : 2'b00;
		end
		
		2'b11: begin
			next_state = (w == 1) ? 2'b00 : 2'b00;
		end
		
		default: next_state = 2'b00;
	endcase
end

always @(posedge clk)
begin
	if (reset)
		z <= 0;
	else if (state == 2'b10 && w == 1)
		z <= 1;
	else
		z <= 0;
end

endmodule
