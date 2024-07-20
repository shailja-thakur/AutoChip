module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if(reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @(state, j, k) begin
	case(state)
		2'b00: begin // state A
			if(j)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		end
		2'b01: begin // state B
			if(k)
				next_state = 2'b00;
			else
				next_state = 2'b01;
		end
		default: next_state = 2'b00;
	endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
