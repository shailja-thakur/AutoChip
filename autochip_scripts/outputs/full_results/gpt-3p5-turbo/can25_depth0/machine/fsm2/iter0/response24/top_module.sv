module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @ (j or k or state) begin
	case (state)
		0: begin
			if (j == 1'b1)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		end
		1: begin
			if (k == 1'b1)
				next_state = 2'b00;
			else
				next_state = 2'b01;
		end
	endcase
end

always @ (posedge clk or areset) begin
	if (areset == 1'b1)
		state <= 2'b00;
	else
		state <= next_state;
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
