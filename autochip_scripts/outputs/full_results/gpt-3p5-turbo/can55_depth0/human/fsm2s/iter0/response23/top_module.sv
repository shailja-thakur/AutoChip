module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

parameter OFF = 0;
parameter ON = 1;

always @(posedge clk, posedge reset) begin
	if (reset)
		state <= OFF;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		OFF: begin
			if (j)
				next_state = ON;
			else
				next_state = OFF;
		end
		ON: begin
			if (k)
				next_state = OFF;
			else
				next_state = ON;
		end
	endcase
end

always @(state) begin
	case (state)
		OFF: out = 0;
		ON: out = 1;
	endcase
end

endmodule
