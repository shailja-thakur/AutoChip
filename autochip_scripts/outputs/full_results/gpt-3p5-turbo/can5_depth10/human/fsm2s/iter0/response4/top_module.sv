module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
wire next_state;

// state encoding
localparam OFF = 2'b00;
localparam ON = 2'b01;

always @(posedge clk) begin
	if (reset)
		state <= OFF;
	else
		state <= next_state;
end

always @(*) begin
	case(state)
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
		default: next_state = OFF;
	endcase
end

assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
